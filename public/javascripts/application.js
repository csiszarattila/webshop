// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function(){
	
	$(".decrease").click(function() {
		var decrease_button = $(this);
		$.get($(this).attr("href"), $(this).serialize(), function(cart_item)
		{
			// Mennyiség frissítése
			decrease_button.next().html(cart_item["quantity"]);
			var price = cart_item["quantity"] * cart_item["product"]["product"]["price"];
			// Ár frissítése
			decrease_button.parent().siblings(".price").children(".value").html(price);
			$("#price-sum ").(".price").children(".value").html(price);
			// Kosár Összár frissítése
			 $("#price-sum > .value").html()
		}, "json");
		return false;
	});
	
});

