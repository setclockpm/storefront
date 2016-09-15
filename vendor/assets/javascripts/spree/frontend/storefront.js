// jQuery for page scrolling feature - requires jQuery Easing plugin
$(function() {
  $('body').on('click', '.page-scroll a', function(event) {
    var $anchor = $(this);
    $('html, body').stop().animate({
        scrollTop: $($anchor.attr('href')).offset().top
    }, 1500, 'easeInOutExpo');
    event.preventDefault();
  });
});

// Floating label headings for the contact form
$(function() {
  $("body").on("input propertychange", ".floating-label-form-group", function(e) {
    $(this).toggleClass("floating-label-form-group-with-value", !! $(e.target).val());
  }).on("focus", ".floating-label-form-group", function() {
    $(this).addClass("floating-label-form-group-with-focus");
  }).on("blur", ".floating-label-form-group", function() {
    $(this).removeClass("floating-label-form-group-with-focus");
  });
});

// Highlight the top nav as scrolling occurs
$('body').scrollspy({ target: '.navbar-fixed-top' })

// Closes the Responsive Menu on Menu Item Click
$('.navbar-collapse ul li a:not(.dropdown-toggle)').click(function() {
  $('.navbar-toggle:visible').click();
});



$(document).ready(function(){
  $('.herro').slick({
    autoplay: true,
    autoplaySpeed: 8000,
    fade: true,
    lazyLoad: 'progressive',
    mobileFirst: true,
    // nextArrow: '<i class="fa fa-arrow-right"></i>',
//     prevArrow: '<i class="fa fa-arrow-left"></i>',
    speed: 1000,
    
    responsive: 
    [{
      breakpoint: 768,
      settings: { dots: true }
    }]
  });
  
  // This may have been part of the startbootstrap teemplate and may not be needed
  // TODO: Check if this is even used.
  $("a[data-toggle=\"tab\"]").click(function(e) {
    e.preventDefault();
    $(this).tab("show");
  });
});
