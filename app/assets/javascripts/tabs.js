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

  $('#showReviews').click(function (e) {
    $('#sprod').removeClass('active');
    $('#srev').addClass('active');
  });
});
