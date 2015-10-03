// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require cocoon
//= require bootstrap-sprockets
//= require bootstrap-timepicker.min
//= require bootstrap-slider
//= require bootstrap-switch
//= require_tree .

$(function() {
  $('.start-timepicker').timepicker('setTime', '9:00 AM');
  $('.end-timepicker').timepicker('setTime', '5:00 PM');
  $('.appt-cost-slider').slider();
  $('.survey-checkbox').bootstrapSwitch({
    onText: 'Yes',
    offText: 'No',
    size: 'small',
    onColor: 'success',
    offColor: 'danger'
  });
});

