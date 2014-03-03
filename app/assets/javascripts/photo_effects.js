$(document).ready(function(){

//reveal text on hover-------------------------------------------
	$("div.space_holder").hover(function(){
	  $(this).closest('div').find('.hidden_text').show("slow");
	},function(){
	  $(".hidden_text").hide("slow");
	});

//scroll when you click arrows-----------------------------------
    var $item = $('div.space_holder'), 
        visible = 2, 
        index = 0, 
        endIndex = ( $item.length / visible ) - 1; 
    
    $('div#forward').click(function(){
        if(index < endIndex ){
          index++;
          $item.animate({'left':'-=1030px'});
        }
    });
    
    $('div#back').click(function(){
        if(index > 0){
          index--;            
          $item.animate({'left':'+=1030px'});
        }
    });




});