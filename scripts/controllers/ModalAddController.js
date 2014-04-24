
/*
Controller for modal box called when we want to add an item to the db
 */
this.ModalAddController = function($scope, $modalInstance) {
  $scope.userItem = {
    artist: "",
    title: ""
  };
  return $scope.done = function() {
    return $modalInstance.close($scope.userItem);
  };
};
