$(document).ready(function(){
  $('.dialog').click(function() {
    $.get($(this).attr('href'),function(resp){
      $("#dialog").html(resp).dialog({ title:"Kép szerkesztése",modal:"true" });
    }, 'html');
    return false;
  });
});