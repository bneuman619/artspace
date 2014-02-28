function show_calendar(selector){
  var calendar = make_calendar(parse(get_calendar_data()));
  $(selector).weekCalendar(calendar);
}

