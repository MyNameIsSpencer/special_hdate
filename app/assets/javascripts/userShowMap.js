

//  ========== Google Maps ==============
initShowMap = function(radInput) {
  if (radInput === undefined) {
    radInput = 10000;
  }
  console.log('This is the start of the User Show map')

// Parsing the logged in User's info from the JSON tag and set Radius
  var loggedUserLatLng = document.getElementById('current_guy');
  var loggedUserLat = JSON.parse(loggedUserLatLng.dataset.latitude);
  var loggedUserLng = JSON.parse(loggedUserLatLng.dataset.longitude);

  // var distance = document.getElementById('distance');
  // console.log(loggedUserLatLng);
  // console.log(loggedUserLat);
  // console.log(loggedUserLng);

// Put the map into the #map div
  var map;
    map = new google.maps.Map(document.getElementById('map'), {
      center: {lat: loggedUserLat, lng: loggedUserLng},
      zoom: 12,
      styles: purple
    });

// Put Marker at User's fsa
    var marker = new google.maps.Marker({
     position: {lat: loggedUserLat, lng: loggedUserLng},
     map: map,
     title: 'Hello World!'
    });

// Convert tag to usable info
   var fsaElement = document.getElementById('fsa_data');
   var fsaData = JSON.parse(fsaElement.dataset.fsa);
   // console.log(fsaElement);
   // console.warn(fsaData);
   var fsaPopulations = {}


populateRadMap(map, loggedUserLat, loggedUserLng, radInput)


 }
