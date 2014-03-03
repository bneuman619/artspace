$(document).ready(function() {
  $("#create_availabilities").on("click", function(event) {
    $.ajax({
      data: {data: modifiedEvents, spaceId: $("#create_availabilities").data().spaceId},
      type: 'post',
      url: '/availabilities',
      dataType: "json",
      success: function(response) {
        if(response.status == 'error') {
          console.log(response);
        }
        else {
          window.location = "/payments/new";
        }
      },
      error: function(xhr, error) {
        alert("there was an error");
      }
    });
  });

   $("#edit_availabilities").on("click", function(event) {
      $.ajax({
        data: {data: modifiedEvents, spaceId: $("#edit_availabilities").data().spaceId},
        type: 'post',
        url: '/spaces/availabilities/update',
        dataType: "json",
        success: function(response) {
          if(response.status == 'error') {
            console.log(response);
          }
          else {
          window.location = "/users/" + $("#edit_availabilities").data().userId + "/manage";
          }
        },

        error: function(xhr, error) {
          alert("there was an error");
        }
    });
  });
});
