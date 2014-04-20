module.exports = class View
	constructor: (@items) ->

	getVisibleElements: ->
		throw new ReferenceError "Not implemented"

	getHiddenElements: ->
		throw new ReferenceError "Not implemented"
