$(document).ready(function(){
	$("div.space_holder").hover(function(){
	  $(this).closest('div').find('.hidden_text').show("slow");
	},function(){
	  $(".hidden_text").hide("slow");
	});
});