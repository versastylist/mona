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

  // Cost Slider in Filter page
  $('.appt-cost-slider').slider();

  // Survey checkboxes
  $('.survey-checkbox').bootstrapSwitch({
    onText: 'Yes',
    offText: 'No',
    size: 'small',
    onColor: 'success',
    offColor: 'danger'
  });

  // Set up Shopping Cart Modal
  $('#myModal').on('shown.bs.modal', function () {
    $('#myInput').focus()
  })

  // Schedule checkboxes
  $('.weekday-checkbox').bootstrapSwitch({
    onText: 'Available',
    offText: 'Busy',
    size: 'small',
    onColor: 'success',
    offColor: 'danger'
  });

  // Timepickers for schedules
  $('.start-timepicker').timepicker('setTime', '9:00 AM');
  $('.end-timepicker').timepicker('setTime', '5:00 PM');

  $('#new_schedule').on('cocoon:after-insert', function(e, insert) {
    $('.interval-start-timepicker').timepicker('setTime', '11:30 AM');
    $('.interval-end-timepicker').timepicker('setTime', '12:30 PM');
  });
});

