$("#things-search").submit(function() {
    $.get($(this).attr("action"), $(this).serialize(), null, "script");
    return false;
  });

$(function() {
  $("#q_name_cont").typeahead()
}
