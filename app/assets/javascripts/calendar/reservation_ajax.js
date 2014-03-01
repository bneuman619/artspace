$(document).ready(function() {

  var handler = StripeCheckout.configure({
    //key: 'pk_test_XYAoxUJ6VE4GGzZr7hQujucR', //Our publishable api key
    key: $('#pub_key').val(),
    //image: '/square-image.png',
    token: function(token, args) {
      //console.log(token.id);
      var data = { token_key: token.id, 
               amount: totCharge, 
               description: title,
               space_id: $("#make_reservation").data("space-id")
             };

      $.post( '/payments/charge', data, function(response) {
        alert( 'success' );
        //console.log(response);
      })
        .done(function() {
          alert( 'second success' );
        })
        .fail(function() {
          alert( 'error' );
        })
        .always(function() {
          alert( 'finished' );
      });
    }
  });
  

  $("#make_reservation").on("click", function(event) {
    event.preventDefault();
    //console.log("stuff");
    $.ajax({
      data: {data: modifiedEvents, spaceId: $("#make_reservation").data().spaceId},
      type: 'post',
      url: '/reservations/',
      dataType: "json",
      success: function(response) {
        //console.log(response.totalCharge);
        totCharge = response.totalCharge;
        title = response.title;
        handler.open({
          name: 'Artspace',
          description: title,
          email: response.email,
          amount: totCharge
        });
      },
      error: function(xhr, error) {
        alert("there was an error");
      }
    });
  });
});


