//Note:
//this js file work but very junky, looking to fix when I have time
//////////////////////////////////////////////////////////////////////
// Add markers to map
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

MapSearch.prototype.fetchJobs = function(query) {
  var url = '/jobs.json?search=' + query;

  $.ajax({
    context: this,
    url: url,
    dataType: 'json',
    success: function(jobs) {
      this.addMarkers(jobs);
      this.resultPanel.updateJobs(jobs);
    }
  });
}

MapSearch.prototype.addMarkers = function(data) {
  // Add markers to map
  this.map.markerLayer.setGeoJSON(data);
  this.updatePopups(data);
}

MapSearch.prototype.updatePopups = function(data) {
  if(data.length > 0){
    var role = data[0].properties.role;
  }
  // Iterate over each marker on the map
  this.map.markerLayer.eachLayer(function(marker) {
    var properties = marker.feature.properties;
    // Create the popup content HTML
    if(role === "Job"){
      var popupContent = "<a href='/jobs/" + properties.id + "'>" + properties.name + "</a>";
    } else {
      var popupContent = "<a href='/users/" + properties.id + "'>" + properties.name + "</a>";
    }
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
  if(users.length > 0){
    var firstuserlat = users[0].geometry.coordinates[1]
    var firstuserlng = users[0].geometry.coordinates[0]
    map.setView([firstuserlat, firstuserlng], 13);
  }
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

ResultPanel.prototype.updateJobs = function(jobs) {
  var firstuserlat = jobs[0].geometry.coordinates[1]
  var firstuserlng = jobs[0].geometry.coordinates[0]
  map.setView([firstuserlat, firstuserlng], 13);

  for (i = 0; i < jobs.length; i++) {
    $(".results-list").append
      ("<div class='panel large-12 columns white_box'>"
        + "<div class='large-8 columns'>"
          + "<a href='/jobs/" + jobs[i].properties.id + "'>"
            + jobs[i].properties.name
          + "</a>"
          + "<div class='address'>"
            + jobs[i].properties.location
          + "</div>"
        + '</div>'
        + "<div class='large-4 small-12 columns'>"
          +"<img class='user_avatar' src='"
            + jobs[i].properties.image
          +"'>"
        + "</div>"
      +"</div>")
    ;
  }
}

$('.search_map').on('submit', function(event) {
  event.preventDefault();
  var $searchInput = $(this).find("input[name='search']");
  var query = $searchInput.val();
  mapSearch.fetchUsers(query);
  $(".results-list").html("<div>" + "</div>");
});

$('.search_job').on('submit', function(event) {
  event.preventDefault();
  var $searchInput = $(this).find("input[name='search']");
  var query = $searchInput.val();
  mapSearch.fetchJobs(query);
  $(".results-list").html("<div>" + "</div>");
});

// var map = L.mapbox.map('map', 'keyfrommapbox', { zoomControl: false } )
//           .setView([42.366, -71.109], 13);
// var mapSearch = new MapSearch(map);

// //change zoom button position and disable zoom by mouse and scroll
      // new L.Control.Zoom({ position: 'topright' }).addTo(map);
      // map.touchZoom.disable();
      // map.doubleClickZoom.disable();
      // map.scrollWheelZoom.disable();
      // // Disable tap handler, if present.
      // if (map.tap) map.tap.disable();

// mapSearch.fetchUsers();
