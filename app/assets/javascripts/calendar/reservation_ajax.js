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
      make_reservation();
    }
  });
});

function make_reservation(token_key) {
  var data = {
    reservation_data: prepare_reservation_data(),
    payment_info: prepare_payment_data(token_key)
  };

  send_reservation(data);
}

function send_reservation(data) {
  $.post('/reservations', data, reservation_response);
}

function reservation_response(response) {
  if(response.status == 'error') {
    alert(response.error)
  }

  else {
    var res_ids = response.reservation_ids.join(',');
    window.location = "/reservations/confirmation?ids=" + res_ids +"&amount=" + response.totalCharge;
  }
}

function prepare_reservation_data() {
  return {
    space_id: $("#make_reservation").data('space-id'),
    reservations: get_events()
  };
}

function prepare_payment_data(token_key) {
  var payment_data = {};

  if (token_key) {
    payment_data.token_key = token_key;
    payment_data.amount = get_total_charge();
    payment_data.description = $("#make_reservation").data().spaceTitle;
  }
  else {
    payment_data.amount = 0;
  }

  return payment_data;
}


