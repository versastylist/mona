$(function() {
  $('#stylistTab a').click(function (e) {
    e.preventDefault()
    $(this).tab('show')
  })

  $('#clientViewTab a').click(function (e) {
    e.preventDefault()
    $(this).tab('show')
  })
});
