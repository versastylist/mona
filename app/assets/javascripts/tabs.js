$(function() {
  function readURL(input, target) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();

      reader.onload = function (e) {
        $(target).attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    }
  }

  $('#stylistTab a').click(function (e) {
    e.preventDefault()
    $(this).tab('show')
    $('#stylistCalendar').fullCalendar('render');

    // image preview
    $("#avatar-upload").change(function(){
      $('#img_prev').removeClass('hidden');
      readURL(this, '#img_prev');
    });

    $("#gallery-upload").change(function(){
      $('#gal_img_prev').removeClass('hidden');
      readURL(this, '#gal_img_prev');
    });

    // revenue forecast
    if ($('#revenueForecast').length) {
      var ctx = $("#revenueForecast").get(0).getContext("2d");

      var weeklyData = $('#revenueData').data().data
      var weeklyLabels = $('#revenueData').data().labels

      var data = {
        labels: weeklyLabels,
        datasets: [
          {
            label: "Weekly Forecast",
            fillColor: "rgba(79,180,119,1)",
            strokeColor: "rgba(63,102,52,1)",
            pointColor: "rgba(52,85,17,1)",
            pointStrokeColor: "#fff",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "rgba(220,220,220,1)",
            data: weeklyData
          },
        ]
      };

      var myLineChart = new Chart(ctx).Line(data, {});
    }
  })

  $('#clientViewTab a').click(function (e) {
    e.preventDefault()
    $(this).tab('show')
  })

  $('#clientDashboard a').click(function (e) {
    e.preventDefault()
    $(this).tab('show')

    // Avatar image preview
    $("#avatar-upload").change(function(){
      $('#img_prev').removeClass('hidden');
      readURL(this, '#img_prev');
    });
  })

  $('#showReviews').click(function (e) {
    $('#sprod').removeClass('active');
    $('#srev').addClass('active');
  });
});
