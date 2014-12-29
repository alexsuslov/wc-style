$ ->
	window.WC.style.val ".window", "{
				position: absolute;
				-khtml-border-radius: 6px;
				border-radius: 6px;
				padding: 16px;
				background-color: #eaeaea; }"

	window.WC.style.val ".window .window-title","{
				background-color: blue;
				color: white;
				padding: 8px;
				-khtml-border-radius: 6px;
				border-radius: 6px;
				margin-bottom: 16px; }"

	window.WC.style.val ".windowMove", "{
				border: 1px solid #bfbfbf;
				-webkit-box-shadow: 0 0 8px #bfbfbf; }"

	wcResize = ->
		h = window.innerHeight
		w = window.innerWidth
		f = 16

		class Size
			f:16
			h: window.innerHeight
			w: window.innerWidth

			constructor:(@data)->
				@Place = @data.place if @data?.place
				@Size = @data.size if @data?.size
				@f = @data.f if @data?.f
				@


			feed:()->
				[
					@Place[0] + @Size[0]
					@Place[1] + @Size[1]
				]


			place:()->
				[
					@Place[0] + @f
					@Place[1] + @f
				]


			size : ()->
		    [
		    	@Size[0] - (3 * @f)
		    	@Size[1] - (3 * @f)
		    ]


		if w < 768
			console.log w
			podbor = new Size
			  place: [0,0]
			  size : [ w , h * .8 ]

			curs = new Size
			  place: [0, podbor.feed()[1]]
			  size : [ w , h * .8 ]

			calc = new Size
			  place: [0, curs.feed()[1]]
			  size : [ w , h * .8 ]

		else

			podbor = new Size
			  place: [0,0]
			  size : [( w * .3) , (h * .6) ]

			curs = new Size
			  place: [( w * .3) ,0]
			  size : [( w * .7) - f , (h * .6) ]

			calc = new Size
			  place: [ 0  , podbor.feed()[1]]
			  size : [ w - f  , (h * .4) - 2 * f ]

		window.WC.style.val
			'#podbor':"{
					position: absolute;
					left:#{podbor.place()[0]}px;
					top:#{podbor.place()[1]}px;
					width:#{podbor.size()[0]}px;
					height:#{podbor.size()[1]}px;}
					"
			'#podbor iframe':"{
					height:#{podbor.size()[1] - 36 - 16}px;}
					"

			'#curs':"{
					position: absolute;
					left:#{curs.place()[0]}px;
					top:#{curs.place()[1]}px;
					width:#{curs.size()[0]}px;
					height:#{curs.size()[1]}px;}
					"

			'#calc':"{
					position: absolute;
					left:#{calc.place()[0]}px;
					top:#{calc.place()[1]}px;
					width:#{calc.size()[0]}px;
					height:#{calc.size()[1]}px;}
					"
	wcResize()

	$(window).resize ->
		setTimeout wcResize, 400
