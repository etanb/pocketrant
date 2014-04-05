var form = document.querySelector("textarea")
var button = document.querySelector("input")

// button.addEventListener("submit", function(e){
//   e.preventDefault();

//   $.post('/users',{ text: form.val() } );

//   this.reset();
// };



$("form#feeling-add").submit(function(e) {
  e.preventDefault();

  $.post('/twilio', { text: form.value } );

  this.reset();

});