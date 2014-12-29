doTest = (message, fn)->
	console.log message
	fn (err, resp)->
		return console.log  "#{err}" if err
		console.log  "#{resp}"


# test
console.log 'window.WC.style ok' if wcStyle = window.WC.style

wcStyle.init()
if  document.getElementById('wcStyle')
	console.log 'wcStyle.init ok'

# addCss
testCSS = '.test{}'
wcStyle.addCss testCSS
if document.getElementById('wcStyle').innerText.search(testCSS) isnt -1
	console.log 'wcStyle.add ok'


# render
wcStyle.render()
if document.getElementById('wcStyle').innerText.search('//version:0.0.1;') isnt -1
	console.log 'wcStyle.render ok'


# add
body=
	margin:0
	padding:0

doTest  'Test wcStyle.val', (fn)->
	wcStyle.val 'body', body
	testCSS = 'body{margin:0;padding:0;}'
	if document.getElementById('wcStyle').innerText.search(testCSS) isnt -1
		fn null, 'ok'
	else
		fn 'error'

# test add object
doTest 'Test wcStyle.val [object]', (fn)->
	testCSS = '.body{margin:0;padding:0;}'
	wcStyle.val '.body': body
	if document.getElementById('wcStyle').innerText.search(testCSS) isnt -1
		fn null, 'ok'
	else
		fn 'error'
