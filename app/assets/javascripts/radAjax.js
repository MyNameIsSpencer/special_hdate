document.addEventListener('DOMContentLoaded', function() {

// var radButton = document.getElementById('radButton');
// radButton.addEventListener('click', function(e) {
//   e.preventDefault();
//   var radInput = document.getElementById("radInput").value
//   console.log(radInput);
//   populateRadMap();
// })

// document.addEventListener('click', function(){
//   document.getElementById("radInput").innerHTML

var radButton = document.getElementById('radButton');
if(radButton){radButton.addEventListener('click', function(e) {
  e.preventDefault();
  var radInput = parseInt(document.getElementById("radInput").value)
  console.log(radInput);
  initShowMap(radInput);
})
}
});
