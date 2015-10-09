$(function() {
  // Full Calendar
  var myCalendar = $('#calendar').fullCalendar({
      header: {
        left: 'prev,next today',
        center: 'title',
        right: 'month,agendaWeek,agendaDay'
      },
      defaultDate: '2014-06-12',
      defaultView: 'agendaDay',
      editable: false,
      events: [
        {
          title: 'All Day Event',
          start: '2014-06-01'
        },
        {
          title: 'Long Event',
          start: '2014-06-07',
          end: '2014-06-10'
        },
        {
          id: 999,
          title: 'Repeating Event',
          start: '2014-06-09T16:00:00'
        },
        {
          id: 999,
          title: 'Repeating Event',
          start: '2014-06-16T16:00:00'
        },
        {
          title: 'Meeting',
          start: '2014-06-12T10:30:00',
          end: '2014-06-12T12:30:00'
        },
        {
          title: 'Lunch',
          start: '2014-06-12T12:00:00'
        },
        {
          title: 'Birthday Party',
          start: '2014-06-13T07:00:00'
        },
        {
          title: 'Click for Google',
          url: 'http://google.com/',
          start: '2014-06-28'
        }
      ],
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
