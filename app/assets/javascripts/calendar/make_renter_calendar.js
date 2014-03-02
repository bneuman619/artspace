modifiedEvents = []

function make_renter_calendar(events_input) {
  var calendar = {
    timeslotsPerHour: 4,
    scrollToHourMillis : 0,

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

    eventDelete: function(calEvent, element, dayFreeBusyManager, calendar, clickEvent) {
        if (confirm('You want to delete this reservation?')) {
          for(i = 0; i < modifiedEvents.length; i++) {
            if (modifiedEvents[i].id == calEvent.id) {
              modifiedEvents.splice(i, 1);
            }
          }

        deleteEvent(calEvent, calendar);
        }
      },

    eventDrop : function(newCalEvent, oldCalEvent, element) {
      removeFreeBusy(oldCalEvent, $("#calendar"));

      for(i = 0; i < modifiedEvents.length; i++) {
        if (modifiedEvents[i].id == newCalEvent.id) {
          modifiedEvents[i] = newCalEvent;
          return true;
        }
      }
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
          console.log(this);
          isFree = false;
          return false;
        }
      });

      if (!isFree) {
        alert('looks like you tried to add an event on busy part !');
        $(calendar).weekCalendar('removeEvent',calEvent.id);
        return false;
      }

      calEvent.id = "new_event" +'_'+ calEvent.start.getTime();

      $(calendar).weekCalendar('updateFreeBusy', {
        start: calEvent.start,
        end: calEvent.end,
        free:false
      });

      $("#event_info").show();
      $("#event_info").dialog({
        modal: true,
        buttons: [
        { 
          text: "Ok", 
          click: function() {
            calEvent.intended_use = $("#description").val();
            calEvent.num_people = $("#count").val();
            $(this).dialog("close");
          }
        }]
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
    allowCalEventOverlap: false,
    dateFormat: 'd F y'
  }

  return calendar;
}

function removeFreeBusy(oldEvent, calendar) {
  var busies = calendar.find(".free-busy-busy");
  var freeBusyManager = calendar.weekCalendar("getFreeBusyManagerForEvent", oldEvent);
  
  for (var i = 0; i < busies.length; i++) {
    var options = $(busies[i]).data().wcFreeBusy.options;

    if (options.start.getTime() == oldEvent.start.getTime() && 
    options.end.getTime() == oldEvent.end.getTime()) {
      
      $(busies).eq(i).removeClass('free-busy-busy').addClass('free-busy-free');
      options.free = true;
      _removeFreeBusyFromManager(oldEvent, freeBusyManager);
      return true;
    }
  }
}

function _removeFreeBusyFromManager(oldEvent, freeBusyManager) {
  for (var i = 0; i < freeBusyManager.freeBusys.length; i++) {
    var options = freeBusyManager.freeBusys[i].options;
    if (options.start.getTime() == oldEvent.start.getTime() && 
    options.end.getTime() == oldEvent.end.getTime()) {
      options.free = true;
    }
  }
}

function deleteEvent(calEvent, calendar) {
  removeFreeBusy(calEvent, calendar);
  calendar.weekCalendar('removeEvent',calEvent.id);
}
