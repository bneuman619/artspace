$(document).ready(function(){
	$("div.space_holder").hover(function(){
	  $(this).closest('div').find('.hidden_text').show("slow");
	},function(){
	  $(".hidden_text").hide("slow");
	});


	$("#forward").click(function(event){
		console.log("hello");
		$('#inner_wrap').animate({left: "-=1040", right: "+=1040"});

		$('#forward').on('click', function(e) {
	      e.preventDefault(); 
	      console.log($('.space_holder:first'));
	      var offset = $('.space_holder:first').next().find('div').offset().top;
	      $('html, body').stop().animate({ scrollTop: offset }, 400);
	   });



	});
});