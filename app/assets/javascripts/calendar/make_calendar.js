modifiedEvents = []

function make_calendar(events_input) {
  var calendar = {
    timeslotsPerHour: 4,
    scrollToHourMillis : 0,

    height: function($calendar){
      return $(window).height() - $('h1').outerHeight(true);
    },

    eventRender : function(calEvent, $event) {
      if (calEvent.end.getTime() < new Date().getTime()) {
        // $event.css('backgroundColor', '#aaa');
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
      console.log("no match");
      
      modifiedEvents.push(newCalEvent);
    },

    eventNew : function(calEvent, $event, FreeBusyManager, calendar) {
      var isFree = true;
      $.each(FreeBusyManager.getFreeBusys(calEvent.start, calEvent.end), function() {
        if (
          this.getStart().getTime() != calEvent.end.getTime()
          && this.getEnd().getTime() != calEvent.start.getTime()
          && !this.getOption('free')
        ){
          isFree = false;
          return false;
        }
      });

      if (!isFree) {
        alert('looks like you tried to add an event on busy part !');
        $(calendar).weekCalendar('removeEvent',calEvent.id);
        return false;
      }

      alert('You\'ve added a new event. You would capture this event, add the logic for creating a new event with your own fields, data and whatever backend persistence you require.');

      calEvent.id = "new_event" +'_'+ calEvent.start.getTime();

      $(calendar).weekCalendar('updateFreeBusy', {
        // userId: calEvent.userId,
        start: calEvent.start,
        end: calEvent.end,
        free: false
      });

      modifiedEvents.push(calEvent);
    },

    data: function(start, end, callback) {
      callback(events_input);
    },

    displayOddEven: true,
    displayFreeBusys: true,
    daysToShow: 7,
    switchDisplay: {'1 day': 1, 'full week': 7},
    headerSeparator: ' ',
    useShortDayNames: true,
    dateFormat: 'd F y'
  }

  return calendar;

}
