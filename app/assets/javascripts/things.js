$(document).ready(function(){

  var searchform=$("#things-search");
  var searchbox=$("#q_name_cont");

  searchform.ready(function() {
      $.get($(this).attr("action"), $(this).serialize(), null, "script");
      return false;
  });

  searchbox.bind("keyup", function() {
      $.get($(this).attr("action"), $(this).serialize(), null, "script");
      return false;
  });
});
