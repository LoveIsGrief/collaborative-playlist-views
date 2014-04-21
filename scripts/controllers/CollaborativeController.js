var CollaborativeController;

CollaborativeController = function($scope) {
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
  ].map(function(item) {
    return {
      object: item,
      hiddenFor: new Set()
    };
  });
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
  return $scope.unhide = function(item, user) {
    return item.hiddenFor["delete"](user);
  };
};

this.collApp.controller("CollaborativeController", ["$scope", CollaborativeController]);
