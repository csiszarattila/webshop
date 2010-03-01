// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

//Send data via get if <acronym title="JavaScript">JS</acronym> enabled
jQuery.fn.getWithAjax = function() {
  this.unbind('click', false);
  this.click(function() {
    $.get($(this).attr("href"), $(this).serialize(), null, "script");
    return false;
  })
  return this;
};

$(document).ready(function() {
  
  $(".increase").click(function() {
    var button = $(this);
    $.get($(this).attr("href"), $(this).serialize(), 
      function(cart_item){
        button.prev().html(cart_item["quantity"]);
        button.parent().parent(".price").html(cart_item["price"]);
      },
    "json"
    );
    
    return false;
  });
});
