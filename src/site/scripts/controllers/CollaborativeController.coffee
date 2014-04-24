CollaborativeController = ($scope, $modal) ->

	$scope.isDescriptionCollapsed = true

	# Helper for putting the given item into a db object
	wrapItemForDb = (item)->
			{
				object: item
				hiddenFor: new Set()
				addedBy: "Cyborg"
			}

	$scope.db = [
			{ artist: "Pendulum", title: "Witchcraft" }
			{ artist: "Rusko", title: "Everyday (Netsky Remix)" }
			{ artist: "Benny Benassi & Public Enemy", title: "Bring The Noise" }
			{ artist: "Britney Spears", title: "BlaBlaBla" }
			{ artist: "Rage Against The Machine", title: "Killing In The Name Of" }
		].map wrapItemForDb

	# Filter function for db items that are hidden to nobody / visible to everybody
	$scope.hiddenToNone = (item)->
		item.hiddenFor.size == 0

	# Filter function for db items that are hidden to every / visible to nobody
	$scope.hiddenToEverybody = (item)->
		item.hiddenFor.size == $scope.users.length

	$scope.users = [
		"Michael"
		"Christina"
		"Emilija"
		"Yann"
	]

	# Tabs for the users
	$scope.userViewTabs = [
		{ title: "Visible", active: true, showsHidden: false}
		{ title: "Hidden", active: false, showsHidden: true}
	]

	# Hides a given item from the user
	$scope.hide = (item, user)->
		item.hiddenFor.add user

	# Renders an item visible to the given user
	$scope.unhide = (item, user)->
		item.hiddenFor.delete user

	# Lets a user add an item to the db
	addItem = (item, user)->
		toAdd = wrapItemForDb item
		toAdd.addedBy = user
		$scope.db.push toAdd

	# http://angular-ui.github.io/bootstrap/#/modal
	# Use "AngularUI Bootstrap: Modal Dialog" to open a a dialog
	# For entering a new song
	$scope.openAddDialog = (user)->
		modalAddDialog = $modal.open {
			templateUrl: "addItemModal.html"
			controller: ModalAddController
			resolve: {
				user: ->
					user
			}
		}

		modalAddDialog.opened.then (input)->
			# Really fucking dirty way to give focus to a form input element :\
			window.setTimeout ->
				document.getElementById("artist-input").focus()
			,100
		, ->
			console.error "lol, fail!"

		modalAddDialog.result.then (userItem)->
			addItem(userItem,user)
		, ->
			console.log "Modal dismissed"

@collApp.controller "CollaborativeController", [ "$scope", "$modal", CollaborativeController]