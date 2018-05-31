import jQuery from "jquery";
import $ from "jquery";
import 'fullcalendar';
import 'fullcalendar/dist/fullcalendar.js';
import 'fullcalendar/dist/fullcalendar.css';
import 'fullcalendar/dist/locale/fr.js';
import 'fullcalendar/dist/locale/en-gb.js';
import "./tour_datepicker.css";


$('#calendar').fullCalendar({
  locale: getLocale(),
  dayClick: function(date, jsEvent, view) {
    var random = Math.floor((Math.random() * 9999999999999) + 1000000000000);
    $('<input>').attr({
        type: 'hidden',
        id: 'tour_booking_dates_attributes_'+ random +'_day',
        name: 'tour[booking_dates_attributes]['+ random +'][day]',
        value: date.format()
    }).appendTo($('#calendar').data("target"));
    $('<input>').attr({
        type: 'hidden',
        id: 'tour_booking_dates_attributes_'+ random +'_close',
        name: 'tour[booking_dates_attributes]['+ random +'][close]',
        value: 0
    }).appendTo($('#calendar').data("target"));
    $(this).css('background-color', '#09529b');
  }
});

function getLocale() {
  if ($('#calendar').data("locale") == "en") {
    return "en-gb"
  } else {
    return $('#calendar').data("locale");
  }
}
