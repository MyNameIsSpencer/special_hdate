function createMap(lat, lng) {
  return new google.maps.Map(document.getElementById('map'), {
    center: {lat, lng},
    zoom: 12,
    styles: purple
  });
}


function calcDistance (lata, lnga, latb, lngb) {
return google.maps.geometry.spherical.computeDistanceBetween(
  new google.maps.LatLng(lata, lnga), new google.maps.LatLng(latb, lngb));
}


//**
// Iterate through Users and find distance from current User
function populateRadMap(map, loggedUserLat, loggedUserLng, myRadius) {

  // Get User data from tag
    var usersLocElement = document.getElementById('user_locations');
    var usersData = JSON.parse(usersLocElement.dataset.userLocation);
    var radUsers = []

  for (var i = 0; i < usersData.length; i ++) {
    var iUser = usersData[i];
    var destinationLat = iUser.latitude
    var destinationLng = iUser['longitude']
    var fromUserDistance = calcDistance(loggedUserLat, loggedUserLng, destinationLat, destinationLng);
    if (fromUserDistance <= myRadius) {
      radUsers.push(iUser);
    }
  }

  //**
    var radFsas = [];
    for (var i = 0; i < radUsers.length; i ++) {
      if (!(radUsers[i]['fsa_name'] in radFsas)){
        hasher = {};
        hasher['fsa_name'] = radUsers[i]['fsa_name'];
        hasher['latitude'] = radUsers[i]['latitude'];
        hasher['longitude'] = radUsers[i]['longitude'];
        hasher['count'] = 0;
        radFsas.push(hasher);
      }
    }

    //**
      //Make circles for each fsa within radius, size depending on number of Users
        for (var i = 0; i < radFsas.length; i++) {
          for (var j = 0; j < radUsers.length; j++) {
            if (radFsas[i]['fsa_name'] === radUsers[j]['fsa_name']) {
              radFsas[i]['count'] += 1;
            }
          }
        }
        for (var i = 0; i < radFsas.length; i ++) {
          later = radFsas[i]['latitude']
          longer = radFsas[i]['longitude']
          fsaPop = radFsas[i]['count']
          new google.maps.Circle({
            strokeColor: 'deeppink',
            strokeOpacity: 1,
            strokeWeight: 2,
            fillColor: 'deeppink',
            fillOpacity: 0.6,
            center: {lat: later, lng: longer},
            map: map,
            radius: fsaPop * 100
          });
        }

        //**
        // Draw rad circle
              new google.maps.Circle({
                strokeColor: 'deeppink',
                strokeOpacity: 0.7,
                strokeWeight: 2,
                fillColor: 'deeppink',
                fillOpacity: 0.2,
                center: {lat: loggedUserLat, lng: loggedUserLng},
                map: map,
                radius: myRadius
              });
}
