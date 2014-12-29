###
Create DOM > head> style object.
JS dinamic manipulation css.
###
# create WC master объект
WC = window.WC || {}

WC.style =
	name: 'wcStyle'
	data:{
		".wcStyle":
			"//version":'0.0.2'
	}


	###
	initialize
   @param opt[Object] params
   @return [Object] this
	###
	init:(@opt)->
		@data = @opt.css if @opt?.css
		@Storage = window['localStorage'] if window['localStorage']
		css = '\n\t.wcStyle .version{//0.0.1}\n'
		head = document.head || document.getElementsByTagName('head')[0]
		@style = document.createElement('style')
		@style.type = 'text/css'
		@style.setAttribute 'id', 'wcStyle'
		@addCss css
		head.appendChild(@style)
		@restore() if @opt?.storage
		@render()
		@


	###
	Css data save to localstorage
  @return [Object] this
	###
	save:->
		@Storage.setItem @name, @data if @Storage
		@


	###
	Css data restore from localstorage
  @return [Object] this
	###
	restore:->
		if dt = @Storage.getItem @name
			@data = @Storage.getItem @name if @Storage
		@


	###
	Css data insert to DOM > head> style
	@param [String] css text
  @return [Object] this
	###
	addCss: (css)->
		if (@style.styleSheet)
		  @style.styleSheet.cssText = css
		else
		  @style.appendChild document.createTextNode css
		@


	###
	Clean DOM > head> style
	@return [Object] this
	###
	empty:()->
		while @style.firstChild
		   @style.removeChild @style.firstChild
		@

	###
	Css data convert to text and put to DOM > head> style
	@return [Object] this
	###
	render:->
		@init() unless @style
		@empty()
		css = ''
		for name of @data
			css +=   (
				if typeof @data[name] is 'string'
					"\n#{name}#{@data[name]}"
				else
					"\n#{name}" + @css @data[name]
				)
		@addCss css
		@


	###
	Get/ set
	@param [String] name
	@param [Object] value
	@return [Object] this
	###
	val:(name, val)->
		return @ unless name
		if Object.prototype.toString.call(name) is '[object String]'
			return @data[name] unless val
			@data[name] = val
		else
			for item of name
				@data[item] = name[item]
		@render()
		@save()
		@

	###
	Json css to text convert
	@param [Object] data
	@return [Sring] css
	###
	css:(data)->
		cssText = ["{"]
		for cs of data
			cssText.push "#{cs}:#{data[cs]};"
		cssText.push '}'
		cssText.join ''

	###
	Helper text selection disable
	@return [Object] this
	###
	disableSelection:->
		$('body').css
			'-ms-user-select': 'none'
			'-moz-user-select': '-moz-none'
			'-khtml-user-select': 'none'
			'-webkit-user-select': 'none'
			'user-select': 'none'

	###
	Helper text selection enable
	@return [Object] this
	###
	enableSelection:->
		$('body').css
			'-ms-user-select': 'auto'
			'-moz-user-select': 'auto'
			'-khtml-user-select': 'auto'
			'-webkit-user-select': 'auto'
			'user-select': 'auto'

window.WC = WC
