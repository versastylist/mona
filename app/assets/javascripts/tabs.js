$(function() {
  $('#stylistTab a').click(function (e) {
    e.preventDefault()
    $(this).tab('show')
    $('#stylistCalendar').fullCalendar('render');
  })

  $('#clientViewTab a').click(function (e) {
    e.preventDefault()
    $(this).tab('show')
  })

  $('#clientDashboard a').click(function (e) {
    e.preventDefault()
    $(this).tab('show')
  })

  $('#showReviews').click(function (e) {
    $('#sprod').removeClass('active');
    $('#srev').addClass('active');
  });
});
