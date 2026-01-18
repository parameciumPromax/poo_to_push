# 喜報，我根本不會寫Julia，agent.jl開源庫想用導致的血案，純AI不添加任何手動修改。
# 第一次用Julia就跳agent火坑，這輩子有了。我只是想模擬NPC走路，怎麼毛那麼多？

using Agents, Random, Agents.Schedulers
using AgentsPlots, Plots

@agent NPC GridAgent{2} begin
    state::Symbol
    speed::Float64
end

@agent Player GridAgent{2} begin
    speed::Float64
end

# 地圖常數
const WALL     = :wall
const FLOOR    = :floor
const EXIT     = :exit
const WALKABLE = Set([FLOOR, EXIT])
const SPEED_FACTOR = Dict(FLOOR => 1.0, EXIT => 1.0)

# 隨機可走位置
function random_walkable(grid)
    w, h = size(grid)
    while true
        x, y = rand(2:w-1), rand(2:h-1)
        if grid[x, y] in WALKABLE
            return (x, y)  # 一定是 Tuple
        end
    end
end

# 產生地圖
function make_map(w,h)
    grid = fill(FLOOR, w, h)
    grid[1,:] .= WALL; grid[end,:] .= WALL
    grid[:,1] .= WALL; grid[:,end] .= WALL
    grid[10,5] = EXIT
    return grid
end

# 初始化模型
function init_model(; w=40, h=25, n_npc=20, β=0.15, γ=0.02)
    grid = make_map(w,h)
    space = GridSpace((w,h); periodic=false)
    model = ABM(Union{NPC,Player}, space;
        properties=Dict(:grid=>grid, :β=>β, :γ=>γ, :exit_pos=>(10,5), :alarm_on=>false, :tick=>0))
    
    # 玩家
    add_agent!(Player(nextid(model), random_walkable(grid), 1.2), model)

    # NPC
    for _ in 1:n_npc
        add_agent!(NPC(nextid(model), random_walkable(grid), :S, 1.0), model)
    end

    return model
end

# 鄰近座標
# 鄰近座標
function neighbors(pos::Tuple{Int,Int}, model)
    x, y = pos
    w, h = size(model.space) # Use the official size function
    cand = [(x+1,y), (x-1,y), (x,y+1), (x,y-1)]
    # Ensure w and h are treated as scalars
    filter(p -> 1 <= p[1] <= w && 1 <= p[2] <= h, cand)
end
# 速度依地形
function tile_speed(grid, pos)
    t = grid[Tuple(pos)...]  # Tuple
    return get(SPEED_FACTOR, t, 0.0)
end

# 移動
function step_move!(agent, model)
    grid = model.properties[:grid]
    dirs = neighbors(agent.pos, model)
    dirs = filter(p -> grid[p...] in WALKABLE, dirs)
    isempty(dirs) && return
    
    # argmax with a function returns the ELEMENT that maximizes it
    best_pos = argmax(p -> tile_speed(grid, p), dirs)
    
    # IMPORTANT: Use move_agent! to keep the grid in sync
    move_agent!(agent, best_pos, model)
end
# NPC資訊傳播
function info_spread!(agent::NPC, model)
    β = model.properties[:β]
    γ = model.properties[:γ]
    if agent.state == :I
        for other in nearby_agents(agent, model, 1.5)
            if other isa NPC && other.state == :S && rand() < β
                other.state = :I
            end
        end
        if rand() < γ
            agent.state = :R
        end
    end
end

# 追玩家
function chase!(agent::NPC, model)
    # Find the player safely
    player_idx = findfirst(a -> a isa Player, collect(allagents(model)))
    player_idx === nothing && return
    player = model[player_idx]
    
    ax, ay = agent.pos
    px, py = player.pos
    dx, dy = sign(px-ax), sign(py-ay)
    
    cand = [(ax+dx, ay), (ax, ay+dy)]
    grid = model.properties[:grid]
    w, h = size(model.space)
    
    cand = filter(p -> 1 <= p[1] <= w && 1 <= p[2] <= h && grid[p...] in WALKABLE, cand)
    if !isempty(cand)
        move_agent!(agent, rand(cand), model)
    end
end
# 單步更新
function agent_step!(agent, model)
    agent.pos = Tuple(agent.pos)
    grid = model.properties[:grid]
    if agent isa Player
        step_move!(agent, model)
    else
        sp = tile_speed(grid, agent.pos)
        if agent.state == :I
            chase!(agent, model)
        else
            step_move!(agent, model)
        end
        info_spread!(agent, model)
        sp < 1.0 && rand() < (1.0-sp) && return
    end
end

# 主迴圈
function run_sim(steps=200)
    model = init_model()
    for _ in 1:steps
        step!(model, agent_step!, 1)
    end
    return model
end

# 初始化模型
model = run_sim(0)

# 繪圖動畫
anim = @animate for step in 1:50
    step!(model, agent_step!, 1)
    g = model.properties[:grid]
    agent_positions = [(Tuple(a.pos)..., a isa NPC ? 0 : 1) for a in allagents(model)]
    scatter([p[1] for p in agent_positions], [p[2] for p in agent_positions],
            c=[p[3] for p in agent_positions], xlim=(1,size(g,1)), ylim=(1,size(g,2)))
end

outpath = joinpath(@__DIR__, "sim.gif")
gif(anim, outpath, fps=5)
@info "GIF saved at $outpath"
println("=== END OF FILE REACHED ===")
