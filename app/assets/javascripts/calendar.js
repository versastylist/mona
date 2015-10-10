$(function() {
  // Full Calendar
  var myCalendar = $('#appointmentCalendar').fullCalendar({
      header: {
        left: 'prev,next today',
        center: 'title',
        right: 'month,agendaWeek,agendaDay'
      },
      defaultDate: '2014-06-12',
      defaultView: 'agendaWeek',
      editable: false,
      events: $('#availableAppointments').data().appointments,
      eventClick: function(calEvent, jsEvent, view) {

          alert('Event: ' + calEvent.title);
          alert('Coordinates: ' + jsEvent.pageX + ',' + jsEvent.pageY);
          alert('View: ' + view.name);

          // change the border color just for fun
          $(this).css('border-color', 'red');

      }
  });

  // myCalendar.fullCalendar( 'renderEvent', myEvent );
});
