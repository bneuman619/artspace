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
