@collApp.filter "viewToUser", ->
	(input, userName, showHidden = true)->
		input.filter (item)->
			hidden = item.hiddenFor.has(userName)
			if showHidden then hidden else not hidden
