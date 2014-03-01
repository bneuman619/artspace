$(document).ready(function() {
  $("#create_availabilities").on("click", function(event) {
    console.log("hello");
    $.ajax({
      data: {data: modifiedEvents, spaceId: $("#create_availabilities").data().spaceId},
      type: 'post',
      url: '/availabilities',
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
