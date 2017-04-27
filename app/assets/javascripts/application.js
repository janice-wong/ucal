// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-sprockets
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require moment 
//= require fullcalendar

$(document).ready(function() {

    // page is now ready, initialize the calendar...

    $('#calendar').fullCalendar({
        // put your options and callbacks here
        header: {
          left:   'today prev,next',
          center: 'title',
          right:  'month,agendaWeek,agendaDay,listWeek'
        },
        events: '/events.json',
        eventRender: function(event, element) { 
          element.find('.fc-event-title').html(event.title);
        },
        selectable: true,
        selectHelper: true,
        select: function() {
          window.location.href = '/events/new';
        },
    });

});