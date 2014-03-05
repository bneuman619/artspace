function make_availability_calendar(events_input) {
  var calendar = {
    dateFormat: 'd F y',
    defaultFreeBusy: {free: true},
    displayFreeBusys: false,
    useShortDayNames: false,

    buttons: false,


    height: function($calendar){
      return $(window).height() - $('h1').outerHeight(true);
    },

    data: function(start, end, callback) {
      callback(events_input);
    },

    title: function() {
      return "Mark the weekly business hours for your space on the calendar below";
    },

    eventNew: function (calEvent) {
      calEvent.id = generateEventId();
    },



    eventDelete: function(calEvent, element, dayFreeBusyManager, calendar, clickEvent) {
      if (confirm('You want to delete this availability slot?')) {
        calendar.weekCalendar('removeEvent',calEvent.id);
      }
    },

    getHeaderDate: function(date, calendar) {
      return get_day(date);
    },


    eventBody: function() {
      return "Available hours";
    },
  }

  return calendar;

}
