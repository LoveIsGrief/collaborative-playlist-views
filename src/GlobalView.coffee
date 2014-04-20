Set = require 'set'
View = require './View'
UserView = require './UserView'
require 'es6-shim'

module.exports = class GlobalView extends View

	###
	Create a globalview with some predifined items
	,which will be concatenated with given objects
	###
	constructor: (objects = [], @items = []) ->

		#Convert hiddenFor to a Set
		@items = @items.map (item)->
			{
				object: item.object
				hiddenFor: new Set item.hiddenFor
			}
		# Wrap and add objects
		.concat objects.map (object)->
			{
				object: object
				hiddenFor: new Set()
			}

		# Get all users from hiddenFor
		@users = @items.reduce (previous, current)->
			previous.union current.hiddenFor
		, new Set()


	hideObjectFor: (object, user) =>
		item = @findItemWithObject object
		if not item.hiddenFor.contains(user)
			item.hiddenFor.add user
			@users.add user


	findItemWithObject: (object) =>
		for item in @items
			if item.object == object
				return item

		console.error object
		throw new ReferenceError "Object not in globalView"

	###
	What a specific user can and cannot see
	###
	getViewOf: (user) =>

		new UserView @, user

	###
	Items that everybody can see.
	###
	getVisibleElements: =>
		@items.filter (item)->
			item.hiddenFor.empty()
		.map (item)->
			item.object

	###
	Items that nobody can see.
	###
	getHiddenElements: =>
		# All users must be in the #hiddenFor field
		@items.filter (item)=>
			item.hiddenFor.difference(@users).empty()
		.map (item)->
			item.object



	####Mutators###


	###
	Add item that is visible to everybody
	###
	add: (object) =>
		@items.push {
			object: object
			hiddenFor: []
		}

	remove: (object) =>
		delete @items @findItemWithObject object

