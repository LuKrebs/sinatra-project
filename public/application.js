$(document).ready(function() {

  $(".last").hide();

  $('#trig').on('click', function() {
    $(".last").fadeIn(1500);
  });

  $("#food").on("click", function() {
    alert("Food Imported :)");
  });
});
