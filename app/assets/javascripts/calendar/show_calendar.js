function show_renter_calendar(selector, read_only){
  var calendar = make_renter_calendar(parse_for_renter(get_calendar_data()));
  if (read_only) {
    calendar.allowEventCreation = false;
  }
  $(selector).weekCalendar(calendar);
}

function show_creation_calendar(selector){
  var calendar = make_availability_calendar(parse_for_new_availabilities());
  $(selector).weekCalendar(calendar);
}

function show_edit_availability_calendar(selector) {
  var calendar = make_availability_calendar(parse_for_availability_edit(get_calendar_data()));
  $(selector).weekCalendar(calendar);
}
