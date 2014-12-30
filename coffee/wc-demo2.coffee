WC = window.WC

class Wnd
	resizeZone: 16
	moveZone: 36

	genId:()->
		Math.random().toString(36).replace(/[^a-z]+/g, '').substr(0, 5)

	constructor:(@opt, @el)->

		@$el = $ el if @el
		@id = @$el.attr 'id'
		@parseCss @opt.style.val "##{@id}"
		@$title = @$el.find '.window-title'
		@name = @$title.text()
		@$title.append "<span>X</span>"
		@$body = @$el.find '.window-body'
		@events()
		# for debug
		window[@id] = @
		@


	parseCss:(str)->
		@data = {} unless @data
		size = [0,0]
		place = [0,0]
		str.replace( /^\{/, '').replace( /\}$/, '').split(';').forEach (value)=>
			value = value.split(':')
			name = $.trim value[0]
			val = $.trim value[1]
			size[0] = parseInt val if name is 'width'
			size[1] = parseInt val if name is 'height'
			place[0] = parseInt val if name is 'left'
			place[1] = parseInt val if name is 'top'
			@data[name] = val if name
		@data.size = size
		@data.place = place
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

	val:(name, val)->
		if val
			 @data[name] = val
			 @updateStyle()
		else
			@data[name]

	mouseMove:(e)->
		switch @state
			when 'bottomResize'
				@val 'size', [@size[0], @size[1] + (e.pageY - @cursor[1]) ]
				@onResize()

			when 'rightResize'
				@val 'size', [@size[0] + (e.pageX - @cursor[0]), @size[1] ]
				@onResize()

			when 'leftResize'
				@val 'size', [
					@size[0] - (e.pageX -  @cursor[0])
					@size[1]
				]
				# place
				place  = @val 'place'
				place[0] = ( e.pageX -  @offset[0])
				@val 'place', place
				@onResize()

			when 'move'
				@val 'place', [e.pageX - @offset[0], e.pageY - @offset[1]]
		@

	events:->
		self = @
		state = @state
		clean = (e)->
			$(window).off 'mousemove'
			self.opt.style.enableSelection()
			self.state = false
			self.$el.removeClass 'windowMove'
			self.$body.show()
			self.$el.css 'z-index', self.z
		@$el.find( '.window-title span').on 'click', (e)->
			self.$el.hide()

		@$el.on 'mouseup', clean
		# @$el.on 'mouseleave', clean

		@$el.on 'mousedown', (e)=>
			# отключаю выделение текста и прячу контент для скорости
			@opt.style.disableSelection()
			@$body.hide()
			# Добавляю класс выделения
			@$el.addClass 'windowMove'
			# сохраняю z-index и поднимаю блок вверх
			@z = @$el.css 'z-index'
			@$el.css 'z-index', 10000

			# сохраняю курсор
			@cursor = [e.pageX, e.pageY]
			@size = @data.size
			@offset = [e.pageX - @el.offsetLeft, e.pageY - @el.offsetTop]

			$(window).on 'mousemove', $.proxy self.mouseMove, self

			@state = (
				if e.offsetY < @moveZone
					'move'
				else if e.offsetX < @resizeZone
					'leftResize'
				else if self.data.size[0] - e.offsetX < @resizeZone
					'rightResize'
				else if self.data.size[1] - e.offsetY < @resizeZone
					'bottomResize'
				else
					false
					)
		@
	onResize:()->

$ ->
	$.fn.wnd = (options)->
		options = options || {}
		@.each ( i, el)->
			options.style = WC.style
			window.WC.taskbar.add new Wnd( options, el)

	$('#taskbar').taskbar()
	$('.wc-window').wnd()

