WC = window.WC || {}

class TaskBar
	name: 'wcPanel'
	version:'0.0.1'

	constructor:(@opt, @el)->
		@$el = $ el if @el
		@id = @$el.attr 'id'
		@parseCss @opt.style.val "##{@id}"
		# for debug
		window[@id] = @
		@


	parseCss:(str)->
		return @ unless str
		@data = {} unless @data
		size = [0,0]
		place = [0,0]
		str.replace( /^\{/, '').replace( /\}$/, '').split(';').forEach (value)=>
			value = value.split(':')
			name = $.trim value[0]
			val = $.trim value[1]
			@data[name] = val if name
		@


	updateStyle:()->
		css = {}
		for name of @data
			switch name
				when 'place'
					css.left = @data.place[0] + 'px'
					css.top = @data.place[1] + 'px'
				when 'size'
					css.width = @data.size[0] + 'px'
					css.height = @data.size[1] + 'px'
				else
					css[name] = @data[name]
		@opt.style.val '#' + @id, css
		@

	add:(window)->
		@windows = [] unless @windows
		@windows.push window
		@render()
		@

	render:->
		$ul = $ '<ul></ul>'
		items = []

		@windows.forEach (wnd)=>
			cls = ''
			btn = $ "
			<li>
				<button type='button' class='#{cls}'>#{wnd.name}</button>
			</li>"
			@event btn, wnd
			items.push btn
		@el.html $ul.html items



	val:(name, val)->
		if val
			 @data[name] = val
			 @updateStyle()
		else
			@data[name]

	event:($btn, wnd)->
		$btn.on 'click', (e)->
			wnd.$el.show()


		@

WC.TaskBar = TaskBar
window.WC = WC

$ ->
	w = window.innerWidth
	WC.style.val
		"#taskbar":"{
			border: 2px outset #d0d0d0;
			width: #{w - 4}px;
			height: 64;
			background-color: #eaeaea;
			position: absolute;
			bottom:0;
			left: 0;
			}"
		"#taskbar ul li":"{
			list-style: none;
			display: inline-block;
			margin-left: 8px;
			}"

		"#taskbar ul li button":"{
			display: inline-block;
			margin-bottom: 0;
			font-weight: normal;
			text-align: center;
			vertical-align: middle;
			-ms-touch-action: manipulation;
			touch-action: manipulation;
			cursor: pointer;
			background-image: none;
			border: 1px solid transparent;
			white-space: nowrap;
			padding: 8px 12px;
			font-size: 16px;
			line-height: 1.42857143;
			border-radius: 4px;
			-webkit-user-select: none;
			-moz-user-select: none;
			-ms-user-select: none;
			user-select: none;
			}"

	$.fn.taskbar = (options)->
		options = options || {}
		options.style = WC.style
		WC.taskbar = new TaskBar( options, @)



