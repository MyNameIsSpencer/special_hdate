// ******* Have yet to pass distance to html
//  ========== Google Maps ==============
initChatMap = function() {
  console.log('Start of the Chat Map')

// Parsing the logged in User's info from the JSON tag and set Radius
  var loggedUserLatLng = document.getElementById('current_guy');
  var loggedUserLat = JSON.parse(loggedUserLatLng.dataset.latitude);
  var loggedUserLng = JSON.parse(loggedUserLatLng.dataset.longitude);
  var receiverLatLng = document.getElementById('receiver_guy');
  var receiverLat = JSON.parse(receiverLatLng.dataset.latitude);
  var receiverLng = JSON.parse(receiverLatLng.dataset.longitude);
  var block = JSON.parse(receiverLatLng.dataset.block)
// Caculate distance between User and Recevier
  var userReceiverDistance = calcDistance(loggedUserLat, loggedUserLng, receiverLat, receiverLng);

// ****** Pass distance to tag *******
  function callback(response) {

  }

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
     title: 'Me'
    });

    var senderCheckbox = false

    var senderInfoWindow = new google.maps.InfoWindow({
      content: "You"
    });


// Put Marker at Receiver's fsa
  if (block===false){
    var otherMarker = new google.maps.Marker({
     position: {lat: receiverLat, lng: receiverLng},
     map: map,
     title: 'Them'
    });

    var receiverInfoWindow = new google.maps.InfoWindow({
      content: "Them"
    });
    var receiverCheckbox = false
  }

  marker.addListener('click', function(event){
    if (senderCheckbox === false) {
   senderInfoWindow.open(map, marker);
   senderCheckbox = true
   } else if (senderCheckbox === true){
   senderInfoWindow.close();
   senderCheckbox = false
   }
   if (receiverCheckbox === true){
  receiverInfoWindow.close();
  receiverCheckbox = false
 }
})

  otherMarker.addListener('click', function(event){
    if (receiverCheckbox === false) {
   receiverInfoWindow.open(map, otherMarker);
   receiverCheckbox = true
 } else if (receiverCheckbox === true){
   receiverInfoWindow.close();
   receiverCheckbox = false
   }
   if (senderCheckbox === true){
     senderInfoWindow.close();
     senderCheckbox = false
 }
  })

// Draw Polyline from User to Receiver fsa
   var differenceCoordinates = [
     {lat: loggedUserLat, lng: loggedUserLng},
     {lat: receiverLat, lng: receiverLng},
   ];
   var differenceLine = new google.maps.Polyline({
     path: differenceCoordinates,
     geodesic: true,
     strokeColor: 'deeppink',
     strokeOpacity: 1.0,
     strokeWeight: 4
   });
   differenceLine.setMap(map);


// ====== Not sure about this V
   callback();

   function callback(response, status) {``
     var results = response.rows[0].elements[0]['distance']['text'];
     distanceText.innerText = ('You are about  ' + results + '  apart');
   };

 }
