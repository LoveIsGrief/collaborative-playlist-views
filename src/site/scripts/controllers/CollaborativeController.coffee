CollaborativeController = ($scope) ->

	$scope.db = [
			{ artist: "Pendulum", title: "Witchcraft" }
			{ artist: "Rusko", title: "Everyday (Netsky Remix)" }
			{ artist: "Benny Benassi & Public Enemy", title: "Bring The Noise" }
			{ artist: "Britney Spears", title: "BlaBlaBla" }
			{ artist: "Rage Against The Machine", title: "Killing In The Name Of" }
		].map (item)->
			{
				object: item
				hiddenFor: new Set()
			}

	$scope.users = [
		"Michael"
		"Christina"
		"Emilija"
		"Yann"
	]

	$scope.userViewTabs = [
		{ title: "Visible", active: true, showsHidden: false}
		{ title: "Hidden", active: false, showsHidden: true}
	]

	$scope.hide = (item, user)->
		item.hiddenFor.add user

	$scope.unhide = (item, user)->
		item.hiddenFor.delete user

@collApp.controller "CollaborativeController", [ "$scope", CollaborativeController]