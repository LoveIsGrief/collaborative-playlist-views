this.collApp.filter("viewToUser", function() {
  return function(input, userName, showHidden) {
    if (showHidden == null) {
      showHidden = true;
    }
    return input.filter(function(item) {
      var hidden;
      hidden = item.hiddenFor.has(userName);
      if (showHidden) {
        return hidden;
      } else {
        return !hidden;
      }
    });
  };
});
