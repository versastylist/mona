$(function() {
  if ($('#new_payment_info').length > 0) { // only execute if on page that needs stripe
    Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'));

    function handleStripeResponse(status, resp) {
      if (status == 200) {
        $('#payment_info_stripe_card_token').val(resp.id);
        $('#new_payment_info')[0].submit()
      } else {
        alert('Something went wrong saving your card')
      }
    }

    $('#new_payment_info').submit(function(e) {
      e.preventDefault()
      var card = {
        number: $('#card_number').val(),
        cvc: $('#card_code').val(),
        expMonth: $('#card_month').val(),
        expYear: $('#card_year').val()
      }
      Stripe.createToken(card, handleStripeResponse)
    });
  }
});
