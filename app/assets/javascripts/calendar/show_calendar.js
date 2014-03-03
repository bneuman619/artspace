function show_renter_calendar(selector){
  var calendar = make_renter_calendar(parse_for_renter(get_calendar_data()));
  $(selector).weekCalendar(calendar);
}

function show_read_only_calendar(selector) {
  var calendar = make_renter_calendar(parse_for_renter(get_calendar_data()));
  calendar.allowEventCreation = false;
  $(selector).weekCalendar(calendar);
}

function show_creation_calendar(selector){
  var eventData = {
    events: [],
    freebusys: [],
  };

  var calendar = make_creation_calendar(eventData);
  $(selector).weekCalendar(calendar);
}

function show_edit_availability_calendar(selector) {
  var data = get_calendar_data();
  var parsed = parse_for_availability_edit(data);

  var calendar = make_availability_edit_calendar(parse_for_availability_edit(get_calendar_data()));
  $(selector).weekCalendar(calendar);
}



