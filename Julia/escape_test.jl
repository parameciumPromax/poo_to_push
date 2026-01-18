using Agents, Random, Plots, AgentsPlots

#----------------------------------------
# 地形設定
const SPEED_FACTOR = Dict(1=>1.0, 2=>0.7)
const WALKABLE = Set([1,2])

function make_map(w,h)
    grid = fill(1, w, h)
    for x in 1:w, y in 1:h
        if x==1 || y==1 || x==w || y==h
            grid[x,y] = 0
        end
    end
    for x in 10:20, y in 5:15
        grid[x,y] = 2
    end
    grid[3,3] = 9
    grid[w-3,h-3] = 9
    return grid
end

#----------------------------------------
# Agent 定義

@agent NPC GridAgent{2} begin
    state::Symbol
    speed::Float64
end

@agent Player GridAgent{2} begin
    speed::Float64
    state::Symbol
end

#----------------------------------------
# 隨機可走位置
function random_walkable(grid)
    w,h = size(grid)
    while true
        x,y = rand(2:w-1), rand(2:h-1)
        if grid[x,y] in WALKABLE
            return (x,y)
        end
    end
end

#----------------------------------------
# 鄰近座標
function neighbors(pos, model)
    x,y = pos
    w,h = model.space.extent
    cand = [(x+1,y),(x-1,y),(x,y+1),(x,y-1)]
    filter(p -> 1 ≤ p[1] ≤ w && 1 ≤ p[2] ≤ h, cand)
end

#----------------------------------------
# 移動
function tile_speed(grid,pos)
    t = grid[pos...]
    get(SPEED_FACTOR,t,0.0)
end

function step_move!(agent, model, dir::Symbol=:none)
    grid = model.props[:grid]
    if agent isa Player && dir != :none
        x,y = agent.pos
        candidate = Dict(
            :w => (x-1,y),
            :s => (x+1,y),
            :a => (x,y-1),
            :d => (x,y+1)
        )
        newpos = candidate[dir]
        if 1 ≤ newpos[1] ≤ size(grid,1) && 1 ≤ newpos[2] ≤ size(grid,2) && grid[newpos...] in WALKABLE
            agent.pos = newpos
        end
    else
        dirs = neighbors(agent.pos, model)
        dirs = filter(p -> grid[p...] in WALKABLE, dirs)
        isempty(dirs) && return
        best_idx = argmax(p -> tile_speed(grid,p), dirs)
        agent.pos = dirs[best_idx]
    end
end

#----------------------------------------
# NPC 追玩家
function npc_chase!(npc, model)
    player = first(a for a in allagents(model) if a isa Player)
    ax, ay = npc.pos
    px, py = player.pos
    dx, dy = sign(px-ax), sign(py-ay)
    cand = [(ax+dx, ay),(ax, ay+dy)]
    grid = model.props[:grid]
    w,h = model.space.extent
    cand = filter(p -> 1 ≤ p[1] ≤ w && 1 ≤ p[2] ≤ h && grid[p...] in WALKABLE, cand)
    isempty(cand) || (npc.pos = rand(cand))
end

#----------------------------------------
# 感染擴散
function info_spread!(npc, model)
    β, γ = model.props[:β], model.props[:γ]
    if npc.state == :I
        for other in nearby_agents(npc, model, 1.5)
            if other isa NPC && other.state == :S && rand() < β
                other.state = :I
            elseif other isa Player && other.state == :S && rand() < β
                other.state = :I
            end
        end
        if rand() < γ
            npc.state = :R
        end
    end
end

#----------------------------------------
# agent_step!
function agent_step!(agent, model; player_dir=:none)
    if agent isa Player
        step_move!(agent, model, player_dir)
    else
        npc_chase!(agent, model)
        info_spread!(agent, model)
    end
end

#----------------------------------------
# 初始化模型
function init_model(; w=40,h=25,n_npc=15,β=0.15,γ=0.02)
    grid = make_map(w,h)
    space = GridSpace((w,h); periodic=false)
    props = Dict(:grid=>grid,:β=>β,:γ=>γ)
    model = StandardABM(Union{NPC,Player}, space;
        agent_step! = agent_step!,
        model_step! = dummystep,
        properties = props
    )

    # 玩家
    ppos = random_walkable(grid)
    add_agent!(ppos, Player, model; speed=1.2, state=:S)

    # NPC
    for _ in 1:n_npc
        pos = random_walkable(grid)
        add_agent!(pos, NPC, model; speed=1.0, state=:S)
    end

    # 紅點生成 I 狀態 NPC
    for pos in ((3,3),(w-3,h-3))
        for _ in 1:2
            add_agent!(pos, NPC, model; speed=1.0, state=:I)
        end
    end
    return model
end

#----------------------------------------
# 互動版遊戲
function run_game(steps=50)
    model = init_model()
    player = first(a for a in allagents(model) if a isa Player)
    anim = @animate for step in 1:steps
        # 讀玩家輸入
        println("輸入方向 w/a/s/d (Enter) 或空白跳過：")
        input = readline()
        dir = isempty(input) ? :none : Symbol(input[1])

        # 單步更新
        for a in allagents(model)
            agent_step!(a, model; player_dir=dir)
        end

        # 檢查玩家感染
        if player.state == :I
            println("玩家被感染！遊戲結束！")
            break
        end

        # 畫動畫
        g = model.props[:grid]
        agent_positions = [(a.pos..., a isa NPC ? 0 : 1) for a in allagents(model)]
        scatter([p[1] for p in agent_positions],[p[2] for p in agent_positions],
            c=[p[3] for p in agent_positions],xlim=(1,size(g,1)),ylim=(1,size(g,2)),
            xlabel="X", ylabel="Y", legend=false)
    end

    if player.state != :I
        println("玩家存活！勝利！")
    end

    gif(anim,"sim_interactive.gif",fps=5)
    println("動畫已生成 → sim_interactive.gif")
end

#----------------------------------------
run_game(steps=50)
