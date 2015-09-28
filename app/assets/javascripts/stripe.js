$(function() {
  if ($('#credit_card_info').length > 0) { // only execute if on page that needs stripe
    Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'));

    function handleCreditResponse(status, resp) {
      if (status == 200) {
        $('#payment_info_stripe_card_token').val(resp.id);
        $('#credit_card_info')[0].submit()
      } else {
        alert('Something went wrong saving your card')
      }
    }

    $('#credit_card_info').submit(function(e) {
      e.preventDefault()
      var card = {
        number: $('#card_number').val(),
        cvc: $('#card_code').val(),
        expMonth: $('#card_month').val(),
        expYear: $('#card_year').val()
      }
      Stripe.createToken(card, handleCreditResponse)
    });
  }

  if ($('#bank_account_info').length > 0) { // only execute if on page that needs stripe
    Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'));

    function handleBankResponse(status, resp) {
      if (status == 200) {
        $('#payment_info_stripe_bank_token').val(resp.id);
        $('#bank_account_info')[0].submit()
      } else {
        alert('Something went wrong saving your bank information')
      }
    }

    $('#bank_account_info').submit(function(e) {
      e.preventDefault()
      var bank = {
        country: 'US',
        currency: 'USD',
        routing_number: $('#routing_number').val(),
        account_number: $('#account_number').val()
      }
      Stripe.bankAccount.createToken(bank, handleBankResponse)
    });
  }
});
