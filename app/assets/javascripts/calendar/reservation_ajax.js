$(document).ready(function() {
  $("#make_reservation").on("click", function(event) {
    console.log("stuff");
    $.ajax({
      data: {data: modifiedEvents, spaceId: $("#make_reservation").data().spaceId},
      type: 'post',
      url: '/reservations/',
      dataType: "json",
      success: function(response) {
        console.log(response);
      },
      error: function(xhr, error) {
        alert("there was an error");
      }
    });
  });
});
