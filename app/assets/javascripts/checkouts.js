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
});