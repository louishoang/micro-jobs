// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery_ready_selector
//= require foundation
//= require foundation/app
//= require mapbox.js
//= require_tree .
$(function(){ $(document).foundation();
  $(".multiselectuser").zmultiselect({
    live: false,
    placeholder: "Please choose",
    filter: true
  });

  /// can't use #job_table th a on click
  //the following .on() can be used to bind to current and future elements
  $("#job_table").on("click", "th a", function(){
    $.getScript(this.href);
    return false;
  });
});
