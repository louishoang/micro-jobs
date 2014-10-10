// class MapSearch
//   def initialize(map)
//     @map = map
//   end

//    def fetch_users

//    end
// end

function MapSearch(map) {
  this.map = map;
}

MapSearch.prototype.fetchUsers = function() {
  $.ajax({
    context: this,
    url: '/users.json',
    dataType: 'json',
    success: this.addMarkers
  });
}

MapSearch.prototype.addMarkers = function(users) {
  // Add markers to map
  this.map.markerLayer.setGeoJSON(users);
  this.updatePopups();
}

MapSearch.prototype.updatePopups = function() {
  // Iterate over each marker on the map
  this.map.markerLayer.eachLayer(function(marker) {
    var properties = marker.feature.properties;
    // Create the popup content HTML
    var popupContent = "<a href='/users/" + properties.id + "'>" + properties.name + "</a>";

    // Bind the popup to the marker
    marker.bindPopup(popupContent, {
      closeButton: true,
      minWidth: 200
    });
  });
}

var map = L.mapbox.map('map', 'louishoang.jn2haba8').setView([42.366, -71.109], 13);
var mapSearch = new MapSearch(map);

mapSearch.fetchUsers();
