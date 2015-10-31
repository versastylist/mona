function updateUser(payload) {
  var userId = $('#userId').data('id');
  var url = '/users/' + userId + '/user_settings';

  $.ajax({
    url: url,
    type: 'PUT',
    dataType: 'JSON',
    data: payload,
    error: function(err) {
      alert('Something went wrong when updating your settings');
    }
  })
}

function handleEnableBooking() {
  var payload = {'user_settings': {'enable_booking': this.checked}}
  updateUser(payload);
}

function handleMultipleServices() {
  var payload = {'user_settings': {'multiple_services': this.checked}}
  updateUser(payload);
}

function handleReceiveTexts() {
  var payload = {'user_settings': {'booking_texts': this.checked}}
  updateUser(payload);
}

function handleReceiveEmails() {
  var payload = {'user_settings': {'booking_emails': this.checked}}
  updateUser(payload);
}


$(function() {
  $('#enableBooking').bootstrapSwitch({
    onText: 'On',
    offText: 'Off',
    size: 'small',
    onColor: 'success',
    offColor: 'danger',
    onSwitchChange: handleEnableBooking,
  });

  $('#multipleServices').bootstrapSwitch({
    onText: 'On',
    offText: 'Off',
    size: 'small',
    onColor: 'success',
    offColor: 'danger',
    onSwitchChange: handleMultipleServices,
  });

  $('#receiveTexts').bootstrapSwitch({
    onText: 'On',
    offText: 'Off',
    size: 'small',
    onColor: 'success',
    offColor: 'danger',
    onSwitchChange: handleReceiveTexts,
  });

  $('#receiveEmails').bootstrapSwitch({
    onText: 'On',
    offText: 'Off',
    size: 'small',
    onColor: 'success',
    offColor: 'danger',
    onSwitchChange: handleReceiveEmails,
  });
});
