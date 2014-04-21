Set::toArray = ->
	array = []
	@.forEach (element)->
		array.push element
	array