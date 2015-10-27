function addSpinner(node) {
  var $spinner = $('<i>').
    addClass('fa fa-spinner fa-pulse').
    css({ marginLeft: '20px' });

  $(node).append($spinner);
  return $spinner
}

function removeSpinner(node) {
  $(node).remove();
}

function buildClientRow(client) {
  var row = $('<tr>');
  row.append($('<td>').text(client.username))
  row.append($('<td>').text(client.first_name))
  row.append($('<td>').text(client.last_name))
  row.append($('<td>').text(client.phone_number))
  // row.append($('<td>').text(client.dob))
  return row
}

function replaceResults(data, target) {
  var newResults = $('<tbody>').attr('id', 'clientResults');

  newResults.append(_.map(data.clients, buildClientRow));

  $(target).replaceWith(newResults);
}

$(function() {
  var clientTitle = $('#clientTitle')

  $('#clientSearch').on('keydown', function(e) {
    if (e.keyCode === 13) {
      var spinner = addSpinner(clientTitle);

      var searchQuery = { 'query': e.target.value };
      var stylistId = $('#stylistId').val();

      var searchUrl = '/users/' + stylistId + '/clients'
      var clientResults = $('#clientResults');

      $.ajax({
        url: searchUrl,
        dataType: 'json',
        data: searchQuery,
        method: 'GET',
        success: function(data) {
          replaceResults(data, clientResults);
          removeSpinner(spinner);
        },
        failure: function(err) {
          alert('Something went wrong when searching')
        }
      })
    }
  });
});
