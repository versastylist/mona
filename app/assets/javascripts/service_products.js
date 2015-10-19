function handleSwitchChange(e) {
  var productID = this.id;
  var $spinner = $('#spin_service_product_' + productID)
  $spinner.show();
  var payload = { 'service_product': {'displayed': this.checked }};

  $.ajax({
    url: '/service_products/' + productID,
    type: 'PATCH',
    dataType: 'JSON',
    data: payload,
    success: function(data) {
      $spinner.hide();
    },
    error: function(err) {
      alert('Something went wrong when updating the product');
    }
  })
}

$(function() {
  $('.service-product-checkbox').bootstrapSwitch({
    onText: 'On',
    offText: 'Off',
    size: 'small',
    onColor: 'success',
    offColor: 'danger',
    onSwitchChange: handleSwitchChange
  });
});
