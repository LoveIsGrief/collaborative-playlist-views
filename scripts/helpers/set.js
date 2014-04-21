Set.prototype.toArray = function() {
  var array;
  array = [];
  this.forEach(function(element) {
    return array.push(element);
  });
  return array;
};
