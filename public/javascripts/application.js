// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function(){
	
	$(".decrease").click(function() {
		var decrease_button = $(this);
		$.get($(this).attr("href"), $(this).serialize(), function(cart)
		{
			// Mennyiség frissítése
			decrease_button.next().html(cart["item"]["quantity"]);
			// Ár frissítése
			decrease_button.parent().siblings(".price").children(".value").html(cart["item"]["price"]);
			// Kosár Összár frissítése
			 $("#price-sum > .value").html(cart["total_price"]);
		}, "json");
		return false;
	});
	
	$(".increase").click(function() {
    var increase_button = $(this);
    $.get($(this).attr("href"), $(this).serialize(), 
      function(cart){
        // Mennyiség frissítése
        increase_button.prev().html(cart["item"]["quantity"]);
  			// Ár frissítése
  			increase_button.parent().siblings(".price").children(".value").html(cart["item"]["price"]);
  			// Kosár Összár frissítése
  			 $("#price-sum > .value").html(cart["total_price"]);
      },"json"
    );
    
    return false;
  });
	
});
