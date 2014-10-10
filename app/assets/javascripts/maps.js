function MapSearch(map) {
  this.map = map;
  this.resultPanel = new ResultPanel();
}

MapSearch.prototype.fetchUsers = function(query) {
  var url = '/users.json?search=' + query;

  $.ajax({
    context: this,
    url: url,
    dataType: 'json',
    success: function(users) {
      this.addMarkers(users);
      this.resultPanel.updateUsers(users);
    }
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

function ResultPanel(el){
  this.$el = $('.search_tool');
  this.$results = this.$el.find('.results-list');
}

ResultPanel.prototype.updateUsers = function(users) {
  for (i = 0; i < users.length; i++) {
    $(".results-list").append
      ("<div class='panel large-12 columns white_box'>"
        + "<div class='large-8 columns'>"
          + "<a href='/users/" + users[i].properties.id + "'>"
            + users[i].properties.name
          + "</a>"
          + "<div class='address'>"
            + users[i].properties.address
          + "</div>"
        + '</div>'
        + "<div class='large-4 small-12 columns'>"
          +"<img class='user_avatar' src='"
            + users[i].properties.image
          +"'>"
        + "</div>"
      +"</div>")
    ;
  }
}

var map = L.mapbox.map('map', 'louishoang.jn2haba8', { zoomControl: false } )
          .setView([42.366, -71.109], 13);
var mapSearch = new MapSearch(map);

// //change zoom button position and disable zoom by mouse and scroll
      new L.Control.Zoom({ position: 'topright' }).addTo(map);
      map.touchZoom.disable();
      map.doubleClickZoom.disable();
      map.scrollWheelZoom.disable();
      // Disable tap handler, if present.
      if (map.tap) map.tap.disable();


mapSearch.fetchUsers();

$('.search_map').on('submit', function(event) {
  event.preventDefault();
  var $searchInput = $(this).find("input[name='search']");
  var query = $searchInput.val();
  mapSearch.fetchUsers(query);
  $(".results-list").html("<div>" + "</div>");
});
