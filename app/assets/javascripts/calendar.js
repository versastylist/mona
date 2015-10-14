$(function() {
  if ($('#availableAppointments').length > 0) {
    // Full Calendar
    var myCalendar = $('#appointmentCalendar').fullCalendar({
      header: {
        left: 'prev,next today',
        center: 'title',
        right: 'agendaWeek,agendaDay'
      },
      defaultDate: new Date(),
      defaultView: 'agendaWeek',
      editable: false,
      events: $('#availableAppointments').data().appointments,
      eventClick: function(calEvent, jsEvent, view) {
        $('#startTime').text(calEvent.start.format('LLLL'));
        $('#endTime').text(calEvent.end.format('LLLL'));

        var weekdayID = calEvent.id.split('_')[0];
        $('#bookLink').attr('href', function(i, h) {
          var paramHash = {
            start: calEvent.start.format(),
            end: calEvent.end.format(),
            weekday_id: weekdayID,
          }

          var $params = $.param(paramHash);
          return h + '&' + $params
        });

        $('#appointmentConfirmation').modal('show');
      },
      eventAfterRender:function( event, element, view ) {
        $(element).attr("id","event_id_"+event._id);
      }
    });
  }

  // myCalendar.fullCalendar( 'renderEvent', myEvent );
});
