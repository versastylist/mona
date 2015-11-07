function toggleWeekDayInputs(inputs, bool) {
  for (i = 0; i < inputs.length; i++) {
    if (inputs[i].type === 'text') {
      $(inputs[i]).prop('disabled', bool)
    }
  }
}

function handleWeekDaySwitchChange(e) {
  e.preventDefault();
  var $panelBody = this.closest('div.panel-body');
  var panelID = $panelBody.id;
  var inputs = $('#' + panelID).find('input');

  if (this.checked === false) {
    toggleWeekDayInputs(inputs, true);
  } else {
    toggleWeekDayInputs(inputs, false);
  }
}

$(function() {
  // Schedule checkboxes
  $('.weekday-checkbox').bootstrapSwitch({
    onText: 'Available',
    offText: 'Busy',
    size: 'small',
    onColor: 'success',
    offColor: 'danger',
    onSwitchChange: handleWeekDaySwitchChange
  });

  // Timepickers for schedules
  $('#new_schedule').on('cocoon:after-insert', function(e, insert) {
    $('.interval-start-timepicker').timepicker('setTime', '11:30 AM');
    $('.interval-end-timepicker').timepicker('setTime', '12:30 PM');
  });

  $('.start-timepicker').each(function(weekDay) {
    if (!this.value) {
      $(this).timepicker('setTime', '9:00 AM')
    } else {
      var time = moment.utc(this.value);
      var formattedTime = time.format('h:mm a')
      $(this).timepicker('setTime', formattedTime);
    }
  });

  $('.end-timepicker').each(function(weekDay) {
    if (!this.value) {
      $(this).timepicker('setTime', '5:00 PM')
    } else {
      var time = moment.utc(this.value);
      var formattedTime = time.format('h:mm a')
      $(this).timepicker('setTime', formattedTime);
    }
  });


  // Edit schedule
  $('.edit_schedule').on('cocoon:after-insert', function(e, insert) {
    $(insert).find('.interval-start-timepicker').timepicker('setTime', '11:30 AM');
    $(insert).find('.interval-end-timepicker').timepicker('setTime', '12:30 PM');
  });

  $('.interval-start-timepicker').each(function(weekDay) {
    if (!this.value) {
      $(this).timepicker('setTime', '11:30 AM')
    } else {
      var time = moment.utc(this.value);
      var formattedTime = time.format('h:mm a')
      $(this).timepicker('setTime', formattedTime);
    }
  });

  $('.interval-end-timepicker').each(function(weekDay) {
    if (!this.value) {
      $(this).timepicker('setTime', '12:30 PM')
    } else {
      var time = moment.utc(this.value);
      var formattedTime = time.format('h:mm a')
      $(this).timepicker('setTime', formattedTime);
    }
  });
});

