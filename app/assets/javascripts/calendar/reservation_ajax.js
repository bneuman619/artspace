$(document).ready(function() {

  $("#make_reservation").on("click", function(event) {
    event.preventDefault();
    var totalCharge = get_total_charge();
    if (totalCharge > 0) {
      handler.open({
        amount: totalCharge
      });
    }

    else {
      send_reservation_info();
    }
  });
});

function send_reservation_info() {
  var data = {space_id: $("#make_reservation").data('space-id'),
             reservations: get_events()};

  $.post('/reservations', data, function(response) {
    if(response.status == 'error') {
      alert(response.error)
    }

    else {
      var res_ids = response.reservation_ids.join(',');
      window.location = "/reservations/confirmation?ids=" + res_ids;
    }
  });
}

function get_total_charge() {
  var rate = $("#make_reservation").data().spaceRate;
  return rate * get_total_time() * 100;
}

function get_total_time() {
  var events = get_events();
  var hours = 0;
  for (var i = 0; i < events.length; i++) {
    var event_length = get_time_diff(events[i]);
    hours += event_length;
  }

  return hours;
}

function get_time_diff(event) {
  var millis = event.end - event.start;
  var hours = millis_to_hours(millis);
  return hours;
}

function millis_to_hours(millis) {
  return millis / 1000 / 60 / 60;
}

function get_events() {
  return $("#calendar").weekCalendar('serializeEvents');
}

