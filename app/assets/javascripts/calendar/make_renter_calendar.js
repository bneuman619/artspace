function make_renter_calendar(events_input) {
  var calendar = {
    // scrollToHourMillis : 0,
    // timeslotsPerHour: 2,
    // timeslotHeight: 20,
    // displayOddEven: true,
    // allowEventDelete: true,
    // daysToShow: 7,
    // headerSeparator: ' ',
    // allowCalEventOverlap: false,
    // businessHours: false,

    dateFormat: 'F d',
    defaultFreeBusy: {free: false},
    displayFreeBusys: true,
    useShortDayNames: true,
    
    switchDisplay: {'1 day': 1, 'full week': 7},
    
    height: function($calendar){
      return $(window).height() - $('h1').outerHeight(true);
    },

    data: function(start, end, callback) {
      callback(events_input);
    },

    eventDelete: function(calEvent, element, dayFreeBusyManager, calendar, clickEvent) {
        if (confirm('You want to delete this reservation?')) {

           calendar.weekCalendar('removeEvent',calEvent.id);
           removeFreeBusy(calEvent, calendar);
        }
      },

    eventDrop : function(newCalEvent, oldCalEvent, element) {
      removeFreeBusy(oldCalEvent, $("#calendar"));
    },

    eventResize : function(newCalEvent, oldCalEvent, element) {
      removeFreeBusy(oldCalEvent, $("#calendar"));
    },

    eventNew : function(calEvent, $event, FreeBusyManager, calendar) {
      var isFree = true;
      calEvent.id = "new_event_" + new Date().getTime();
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

    },

    eventBody: function() {
      return "Reservation";
    },

    title: function(date, calendar) {
      return new Date().getMonthName() + " " + new Date().getFullYear();
    }

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
  removeEvent(calEvent, calendar);
}

function removeEvent(calEvent, calendar) {
  calendar.weekCalendar('removeEvent',calEvent.id);
}

function generateEventId() {
  return "new_event_" + new Date().getTime();
}
