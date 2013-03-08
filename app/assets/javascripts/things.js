$(document).ready(function(){

  var liveSearch = (function() {
    $.get($(this).attr("action"), $(this).serialize(), null, "script");
    return false;
  });

  $("#things-search").ready(liveSearch);
  $("#q_name_cont").bind("keyup", liveSearch);

});
