$(function() {
  $('#stylistTab a').click(function (e) {
    e.preventDefault()
    $(this).tab('show')
    $('#calendar').fullCalendar('render');
  })

  $('#clientViewTab a').click(function (e) {
    e.preventDefault()
    $(this).tab('show')
  })
});
