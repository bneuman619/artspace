function show_renter_calendar(selector){
  var calendar = make_calendar(parse_for_renter(get_calendar_data()));
  $(selector).weekCalendar(calendar);
}

function show_calendar(selector){
  var calendar = make_calendar(parse(get_calendar_data()));
  $(selector).weekCalendar(calendar);
}

function show_creation_calendar(selector){
  var eventData = {
    options: {
        timeslotsPerHour: 3,
        timeslotHeight: 30,
        defaultFreeBusy: {free: true}
      },

    events: [],
    freebusys: [],
  };

  var calendar = make_creation_calendar(eventData);
  $(selector).weekCalendar(calendar);
}

function show_edit_availability_calendar(selector) {
  var data = get_calendar_data();
  console.log(data);
  var parsed = parse_for_availability_edit(data);
  console.log(parsed);

  var calendar = make_availability_edit_calendar(parse_for_availability_edit(get_calendar_data()));
  $(selector).weekCalendar(calendar);
}
