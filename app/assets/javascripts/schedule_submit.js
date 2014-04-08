var scheduleform = document.querySelector("#schedule-text")
var button = document.querySelector("input")


$("form#schedule-add").submit(function(e) {
  e.preventDefault();

  $.post('/twilio/schedule', { text: scheduleform.value } );

  this.reset();

});


