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
     $("input.btn").removeAttr("disabled");
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
    autoplaySpeed: 3500,
    fade: true,
    lazyLoad: 'progressive',
    mobileFirst: true,
    speed: 1000,
    
    responsive: 
    [{
      breakpoint: 768,
      settings: { dots: true }
    }]
  });
});


// Old validation method for select box opn contact page. 
// $(document).ready(function() {
//   $.validator.setDefaults({
//     /*OBSERVATION: note how the ignore option is placed in here*/
//     ignore: ':not(select:hidden, input:visible, textarea:visible)',
//
//     /*...other options omitted to focus on the OP...*/
//
//     errorPlacement: function (error, element) {
//       if (element.hasClass('bs-select')) {
//           error.insertAfter('.bootstrap-select');
//       } else {
//         console.log("element", element);
//         console.log("error", error);
//         element.parent().find(".help-block").first().html(error);
//       }
//       /*Add other (if...else...) conditions depending on your
//       * validation styling requirements*/
//     }
//   });
//   $('#new_message').validate({
//     debug: true,
//     rules: {
//       'message[subject]': { required: true }
//     },
//     messages: {
//       'message[subject]': { required: 'Please tell us what this is regarding' }
//     }
//   });
// });