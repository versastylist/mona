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
        $('#bookLink').attr('href', function(i, h) {
          var paramString = '?start=' + calEvent.start.format() + '&end=' + calEvent.end.format();
          return h + paramString
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
