View = require './View'

module.exports = class UserView extends View

	constructor: (@globalView, @name) ->

	hide: (toHide) =>
		if Array.isArray toHide
			for item in toHide
				@globalView.hideObjectFor item, @name

		else
			@globalView.hideObjectFor toHide, @name

	getVisibleElements: =>
		@globalView.items.filter (item)=>
			not item.hiddenFor.contains(@name)
		.map (item) ->
			item.object

	###
	All elements hidden to this user
	###
	getHiddenElements: =>
		@globalView.items.filter (item)=>
			item.hiddenFor.contains(@name)
		.map (item) ->
			item.object
