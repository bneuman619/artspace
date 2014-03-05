function stripe_config() {
  var stripe_config = {
    name: "Artspace",
    key: $('#pub_key').val(),
    description: $("#make_reservation").data().spaceTitle,
    email: $("#make_reservation").data().spaceEmail,
    token: stripe_token_handler
  };

  return stripe_config;
}

function stripe_token_handler(token, args) {
  make_reservation(token.id);
}
