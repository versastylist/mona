function toggleInputs(inputs, bool) {
  for (i = 0; i < inputs.length; i++) {
    if (inputs[i].type === 'text') {
      $(inputs[i]).prop('disabled', bool)
    }
  }
}

function handleSwitchChange(e) {
  var $panelBody = this.closest('div.panel-body');
  var panelID = $panelBody.id;
  var inputs = $('#' + panelID).find('input');

  if (this.checked === false) {
    toggleInputs(inputs, true);
  } else {
    toggleInputs(inputs, false);
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
    onSwitchChange: handleSwitchChange
  });
});
