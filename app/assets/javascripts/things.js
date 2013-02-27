$(document).ready(function(){
  $("#things-search").submit(function() {
      $.get($(this).attr("action"), $(this).serialize(), null, "script");
      return false;
  });

  $("#q_name_cont.string.required").typeahead();
});
