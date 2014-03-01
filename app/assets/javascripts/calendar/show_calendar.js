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

