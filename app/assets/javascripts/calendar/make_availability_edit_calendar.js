function make_availability_edit_calendar(events_input) {
  var calendar = {
    allowEventDelete: true,
    timeslotsPerHour: 2,
    timeslotHeight: 20,
    scrollToHourMillis : 0,
    defaultFreeBusy : {free: true},
    displayFreeBusys: false,
    allowEventDelete: true,
    displayOddEven: true,
    daysToShow: 7,
    headerSeparator: ' ',
    useShortDayNames: true,
    dateFormat: 'd F y',
    allowCalEventOverlap: false,
    buttons: false,

    height: function($calendar){
      return $(window).height() - $('h1').outerHeight(true);
    },

    eventRender : function(calEvent, $event) {
      if (calEvent.end.getTime() < new Date().getTime()) {
        $event.find('.wc-time').css({
          backgroundColor: '#999',
          border:'1px solid #888'
        });
      }
    },

    title: function() {
      return "Mark the weekly business hours for your space on the calendar below";
    },

    eventDelete: function(calEvent, element, dayFreeBusyManager, calendar, clickEvent) {
      if (confirm('You want to delete this reservation?')) {
        removeEvent(calEvent, calendar);
      }
    },

    data: function(start, end, callback) {
      callback(events_input);
    },

    getHeaderDate: function(date, calendar) {
      return get_day(date);
    },

    eventBody: function() {
      return "Available hours";
    }
  }
  return calendar;

}


