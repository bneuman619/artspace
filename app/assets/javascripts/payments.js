
// var handler = StripeCheckout.configure({
//   key: 'pk_test_XYAoxUJ6VE4GGzZr7hQujucR', //Our publishable api key
//   //image: '/square-image.png',
//   token: function(token, args) {
//     console.log(token.id);
//     window.location = "/stripe/charge?token_id=" + token.id;
//     // Use the token to create the charge with a server-side script.
//     // You can access the token ID with `token.id`
//   }
// });

// document.getElementById('customButton').addEventListener('click', function(e) {
//   // Open Checkout with further options
//   handler.open({
//     name: 'Demo Site',
//     description: '2 widgets ($20.00)',
//     amount: 2000
//   });
//   e.preventDefault();
// });