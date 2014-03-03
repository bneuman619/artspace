$(document).ready(function(){
  // $('img').hover(function(){
	$("div.space_holder").hover(function(){
	  $(this).closest('div').find('.hidden_text').show();
	},function(){
	  $(".hidden_text").hide();
	});
});