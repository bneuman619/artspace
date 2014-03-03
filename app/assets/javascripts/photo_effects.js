$(document).ready(function(){
	$("div.space_holder").hover(function(){
	  $(this).closest('div').find('.hidden_text').show("slow");
	},function(){
	  $(".hidden_text").hide("slow");
	});


	// $("#forward").click(function(event){
	//   console.log("hello");
	//   var first = $('.space_holder:first')




    var $item = $('div.space_holder'), //Cache your DOM selector
        visible = 2, //Set the number of items that will be visible
        index = 0, //Starting index
        endIndex = ( $item.length / visible ) - 1; //End index
    
    $('div#forward').click(function(){
        if(index < endIndex ){
          index++;
          $item.animate({'left':'-=1040px'});
        }
    });
    
    $('div#back').click(function(){
        if(index > 0){
          index--;            
          $item.animate({'left':'+=1040px'});
        }
    });













	// });
});