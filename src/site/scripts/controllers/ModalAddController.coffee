###
Controller for modal box called when we want to add an item to the db
###
@ModalAddController = ($scope, $modalInstance)->
	$scope.userItem = { artist: "", title: ""}

	# Basically called when we "submit" the form
	$scope.done = ->
		$modalInstance.close($scope.userItem)