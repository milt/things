$(document).ready(function(){
  $(function() {
    $('#checkout-pickup-at').datetimepicker({
      language: 'en',
      pick12HourFormat: true
    });
  });

  $(function() {
    $('#checkout-return-at').datetimepicker({
      language: 'en',
      pick12HourFormat: true
    });
  });

  var liveSearch = (function() {
    $.get($(this).attr("action"), $(this).serialize(), null, "script");
    return false;
  });

  $("#embed-things-search").ready(liveSearch);
  $(".embed-search#q_name_cont").bind("keyup", liveSearch);
});