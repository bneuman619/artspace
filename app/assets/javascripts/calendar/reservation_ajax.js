$(document).ready(function() {
  $("#make_reservation").on("click", function(event) {
    event.preventDefault();
    var totalCharge = get_total_charge();
    if (totalCharge > 0) {
      handler.open({
        amount: totalCharge
      });
    }

    else {
      send_reservation_info();
    }
  });
});

function send_reservation_info() {
  var data = {space_id: $("#make_reservation").data('space-id'),
             reservations: get_events()};

  $.post('/reservations', data, function(response) {
    if(response.status == 'error') {
      alert(response.error)
    }

    else {
      var res_ids = response.reservation_ids.join(',');
      window.location = "/reservations/confirmation?ids=" + res_ids + "&amount=0";
    }
  });
}

