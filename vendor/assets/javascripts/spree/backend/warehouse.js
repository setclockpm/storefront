$(document).ready(function(){
  $(function() {
    $('input#product_retail_vendor_url').keyup(function() {
      $('input#product_retail_vendor').val(getRetailVendorName($(this).val()));
    });
  });
  
  function getRetailVendorName(url) {
    var wayfair   = new RegExp(/wayfair/i);
    var overstock = new RegExp(/overstock/i);
    
    if (wayfair.test(url)) {
      return "Wayfair"
    } else if (overstock.test(url))  {
      return "Overstock"
    }
  }
});


