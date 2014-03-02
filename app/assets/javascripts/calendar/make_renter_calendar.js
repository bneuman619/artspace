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

    eventDelete: function(calEvent, element, dayFreeBusyManager, calendar, clickEvent) {
        if (confirm('You want to delete this reservation?')) {
          for(i = 0; i < modifiedEvents.length; i++) {
            if (modifiedEvents[i].id == calEvent.id) {
              modifiedEvents.splice(i, 1);
            }
          }

          $.each(dayFreeBusyManager.getFreeBusys(calEvent.start, calEvent.end), function() {
            this.options.free = true;
          });

          calendar.weekCalendar('removeEvent',calEvent.id);
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

    data: get_data(events_input),


    // data: null,

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

function get_data(events_input) {
  if (events_input) {
    return function(start, end, callback) {
      callback(events_input);
    }
  }
  else {
    return null;
  }
}


// function modal_dialog(reservation) {



// }