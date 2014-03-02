$(document).ready( function() {
});

function parse(calendar_data) {
  for(var i = 0; i < calendar_data.openings.length; i++) {
    calendar_data.openings[i].free = true;
  }

  var eventData = {
    options: {
        timeslotsPerHour: 3,
        timeslotHeight: 30,
        defaultFreeBusy: {free: false}
      },

    events : calendar_data.reservations,

    freebusys: calendar_data.openings
  };

  return eventData;
}

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
    options: {
        timeslotsPerHour: 3,
        timeslotHeight: 30,
        defaultFreeBusy: {free: false}
      },

    events : [],

    freebusys: calendar_data.openings.concat(calendar_data.reservations)
  };

  return eventData;
}
