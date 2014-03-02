modifiedEvents = []
new_id_counter = 1;

function make_availability_edit_calendar(events_input) {
  var calendar = {
    allowEventDelete: true,
    timeslotsPerHour: 2,
    timeslotHeight: 20,
    scrollToHourMillis : 0,
    defaultFreeBusy : {free: true},

    height: function($calendar){
      return $(window).height() - $('h1').outerHeight(true);
    },

    eventRender : function(calEvent, $event) {
      calEvent.id = new_id_counter;
      new_id_counter += 1;
      modifiedEvents.push(calEvent);
      
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

    eventDelete: function(calEvent, element, dayFreeBusyManager, calendar, clickEvent) {
      if (confirm('You want to delete this reservation?')) {
        for(i = 0; i < modifiedEvents.length; i++) {
          if (modifiedEvents[i].id == calEvent.id) {
            modifiedEvents.splice(i, 1);
          }
        }

        calendar.weekCalendar('removeEvent',calEvent.id);
      }
    },

    eventNew : function(calEvent, $event, FreeBusyManager, calendar) {
      calEvent.id = "new_event" +'_'+ calEvent.start.getTime();
      modifiedEvents.push(calEvent);
    },

    data: function(start, end, callback) {
      callback(events_input);
    },

    allowEventDelete: true,
    displayOddEven: true,
    displayFreeBusys: false,
    daysToShow: 7,
    switchDisplay: {'1 day': 1, 'full week': 7},
    headerSeparator: ' ',
    useShortDayNames: true,
    dateFormat: 'd F y'
  }

  return calendar;

}


