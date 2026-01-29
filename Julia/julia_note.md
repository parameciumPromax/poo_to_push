並非筆記

1. 關於 `multiple dispatch`(多重分派)

	AI 說這種是`function(objecct)`，而不是一般所熟知的`object.method()`，抽象。

*e.g.1.1*
	
	function

		first

		second    # **它會挑最符合條件的(假設是second)精確配對**

		third   
	end

*e.g.1.2*
		
	function

		first   # 不動

		second  # 執行

		third   # 不動

	end
	
如果裡面的類型不夠精確，會報錯。

*e.g.2*

	function
	
		foo(x::Int, y::Any)    # Julia: 蛤
		
		foo(x::Any, y::Int)
		
	end
	
簡單來說就是如果入口是一個圓，那Julia就會找最像圓形的放進去；給它三個圓的，它就會搞不清楚而`ambiguity error`。需要定義更精確解決型別衝突

3. Agent.jl
其實是外星高等文明開發的庫。
非常有主見，認為所有東西都是一個群體，常常把東西包成`vector`，造成型別檢查沒過得拆包。~~三天兩頭改標準和語法的傢伙。~~

	`key`如果摻雜`\r\n`、`\n`這種不可見字，會error。

	`key`也可能被打包成`vector`導致找不到。要初始化`add_agent!`

	還有一對macro

5. `for`從1開始

6. macro超級噁心，不是單純的替換文字，是自製語法。乾淨衛生不汙染同時要手動。

7. `module`區域是不可見的(類似private)外面無法呼叫裡面除非`export`

8. 是`println`不是`printIn`，字體很重要
