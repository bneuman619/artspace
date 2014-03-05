function get_calendar_data() {
  var calendar_data = JSON.parse($("#calendar_info").html());
  return calendar_data;
}

function parse_for_renter(calendar_data) {
  for(var i = 0; i < calendar_data.openings.length; i++) {
    calendar_data.openings[i].free = true;
  }

  for(var i = 0; i < calendar_data.reservations.length; i++) {
    calendar_data.reservations[i].free = false;
    delete calendar_data.reservations[i].title;
  }

  var eventData = {
    events : [],
    freebusys: calendar_data.openings.concat(calendar_data.reservations),
    options : calendar_options()
  };

  return eventData;
}

function parse_for_availability_edit(calendar_data) {
  var eventData = {
    events : calendar_data,
    freebusys: [],
    options : calendar_options()
  };

  return eventData;
}

function parse_for_new_availabilities() {
  var eventData = {
    events : [],
    freebusys: [],
    options : calendar_options()
  };

  return eventData;
}

function calendar_options() {
  var calendar_options = {
    scrollToHourMillis : 0,
    timeslotsPerHour: 2,
    timeslotHeight: 20,
    displayOddEven: true,
    allowEventDelete: true,
    daysToShow: 7,
    headerSeparator: ' ',
    allowCalEventOverlap: false,
    businessHours: false,
  };

  return calendar_options;
}

function get_day(date) {
  var day_num = date.getDay();
  var day = $("#calendar").data().uiWeekCalendar.options.longDays[day_num];
  return day;
}
