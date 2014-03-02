modifiedEvents = []

function make_creation_calendar(events_input) {
  var calendar = {
    timeslotsPerHour: 4,
    scrollToHourMillis : 0,
    defaultFreeBusy : {free: true},

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

    eventDrop : function(newCalEvent, oldCalEvent, element) {
      for(i = 0; i < modifiedEvents.length; i++) {
        if (modifiedEvents[i].id == newCalEvent.id) {
          modifiedEvents[i] = newCalEvent;
          return true;
        }
      }
      modifiedEvents.push(newCalEvent);
    },

    eventNew : function(calEvent, $event, FreeBusyManager, calendar) {
      alert('You\'ve added a new event. You would capture this event, add the logic for creating a new event with your own fields, data and whatever backend persistence you require.');

      calEvent.id = "new_event" +'_'+ calEvent.start.getTime();

      modifiedEvents.push(calEvent);
    },

    eventDelete: function(calEvent, element, dayFreeBusyManager, calendar, clickEvent) {
      if (confirm('You want to delete this reservation?')) {
        for(i = 0; i < modifiedEvents.length; i++) {
          if (modifiedEvents[i].id == calEvent.id) {
            modifiedEvents.splice(i, 1);
          }
        }
      }
    },

    data: function(start, end, callback) {
      callback(events_input);
    },

    displayOddEven: true,
    displayFreeBusys: false,
    allowEventDelete: true,
    daysToShow: 7,
    switchDisplay: {'1 day': 1, 'full week': 7},
    headerSeparator: ' ',
    useShortDayNames: true,
    allowCalEventOverlap: false,
    dateFormat: 'd F y',
  }

  return calendar;

}
