import jQuery from "jquery";
import $ from "jquery";
import 'fullcalendar';
import 'fullcalendar/dist/fullcalendar.js';
import 'fullcalendar/dist/fullcalendar.css';
import 'fullcalendar/dist/locale/fr.js';
import 'fullcalendar/dist/locale/en-gb.js';
import "./tour_datepicker.css";

$( document ).ready(function() {
  $('#calendar').fullCalendar({
    height: "auto",
    locale: getLocale(),
    dayClick: function(date, jsEvent, view) {
      if ($(this).css('background-color') != "rgb(61, 118, 175)") {
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
        $(this).css('background-color', '#3D76AF');
        $(this).data('field', random);
      } else {
        $("input[id*='" + $(this).data('field') + "']").remove();
        $(this).css('background-color', '#fff');
      }
    }
  });

  if (!isBlank($('#calendar').data("booking-dates"))) {
    for(var i = 0; i < $('#calendar').data("booking-dates").length; i++) {
      var obj = $('#calendar').data("booking-dates")[i];

      $("*").find(`[data-date='${obj.day}']`).css('background-color', '#3D76AF');

      var random = Math.floor((Math.random() * 9999999999999) + 1000000000000);
      $('<input>').attr({
          type: 'hidden',
          id: 'tour_booking_dates_attributes_'+ random +'_day',
          name: 'tour[booking_dates_attributes]['+ random +'][day]',
          value: obj.day
      }).appendTo($('#calendar').data("target"));
      $('<input>').attr({
          type: 'hidden',
          id: 'tour_booking_dates_attributes_'+ random +'_close',
          name: 'tour[booking_dates_attributes]['+ random +'][close]',
          value: 0
      }).appendTo($('#calendar').data("target"));
    }
  }
});

function getLocale() {
  if ($('#calendar').data("locale") === "en") {
    return "en-gb"
  } else {
    return $('#calendar').data("locale");
  }
}

function isBlank(str) {
    return (!str || /^\s*$/.test(str));
}
