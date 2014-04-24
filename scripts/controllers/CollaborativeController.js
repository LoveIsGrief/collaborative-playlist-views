var CollaborativeController;

CollaborativeController = function($scope, $modal) {
  var addItem, wrapItemForDb;
  $scope.isDescriptionCollapsed = true;
  wrapItemForDb = function(item) {
    return {
      object: item,
      hiddenFor: new Set(),
      addedBy: "Cyborg"
    };
  };
  $scope.db = [
    {
      artist: "Pendulum",
      title: "Witchcraft"
    }, {
      artist: "Rusko",
      title: "Everyday (Netsky Remix)"
    }, {
      artist: "Benny Benassi & Public Enemy",
      title: "Bring The Noise"
    }, {
      artist: "Britney Spears",
      title: "BlaBlaBla"
    }, {
      artist: "Rage Against The Machine",
      title: "Killing In The Name Of"
    }
  ].map(wrapItemForDb);
  $scope.hiddenToNone = function(item) {
    return item.hiddenFor.size === 0;
  };
  $scope.hiddenToEverybody = function(item) {
    return item.hiddenFor.size === $scope.users.length;
  };
  $scope.users = ["Michael", "Christina", "Emilija", "Yann"];
  $scope.userViewTabs = [
    {
      title: "Visible",
      active: true,
      showsHidden: false
    }, {
      title: "Hidden",
      active: false,
      showsHidden: true
    }
  ];
  $scope.hide = function(item, user) {
    return item.hiddenFor.add(user);
  };
  $scope.unhide = function(item, user) {
    return item.hiddenFor["delete"](user);
  };
  addItem = function(item, user) {
    var toAdd;
    toAdd = wrapItemForDb(item);
    toAdd.addedBy = user;
    return $scope.db.push(toAdd);
  };
  return $scope.openAddDialog = function(user) {
    var modalAddDialog;
    modalAddDialog = $modal.open({
      templateUrl: "addItemModal.html",
      controller: ModalAddController,
      resolve: {
        user: function() {
          return user;
        }
      }
    });
    modalAddDialog.opened.then(function(input) {
      return window.setTimeout(function() {
        return document.getElementById("artist-input").focus();
      }, 100);
    }, function() {
      return console.error("lol, fail!");
    });
    return modalAddDialog.result.then(function(userItem) {
      return addItem(userItem, user);
    }, function() {
      return console.log("Modal dismissed");
    });
  };
};

this.collApp.controller("CollaborativeController", ["$scope", "$modal", CollaborativeController]);
