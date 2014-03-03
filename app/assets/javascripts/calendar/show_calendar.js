function show_renter_calendar(selector){
  var calendar = make_renter_calendar(parse_for_renter(get_calendar_data()));
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




// function show_calendar(selector){
//   var calendar = make_calendar(parse(get_calendar_data()));
//   $(selector).weekCalendar(calendar);
// }

// function parse(calendar_data) {
//   for(var i = 0; i < calendar_data.openings.length; i++) {
//     calendar_data.openings[i].free = true;
//   }

//   var eventData = {
//     options: {
//         timeslotsPerHour: 3,
//         timeslotHeight: 30,
//         defaultFreeBusy: {free: false}
//       },

//     events : calendar_data.reservations,

//     freebusys: calendar_data.openings
//   };

//   return eventData;
// }
