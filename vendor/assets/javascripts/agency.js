
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
    nextArrow: '<img title="next-arrow" src="/assets/next-arrow.png" class="slick-next next"/>',
    prevArrow: '<img title="prev-arrow" src="/assets/prev-arrow.png" class="slick-prev prev"/>',
    speed: 1000,
    
    responsive: 
    [{
      breakpoint: 768,
      settings: { dots: true }
    }]
  });
  
  $('.gallery-popup').magnificPopup({
    callbacks: {
      elementParse: function(item) {
        // Function will fire for each target element
        // "item.el" is a target DOM element (if present)
        // "item.src" is a source that you may modify
        console.log(item); // Do whatever you want with "item" object
      }
    },
    delegate: 'a.collection-img-link', // child items selector, by clicking on it popup will open
    gallery: {
      enabled: true,
      navigateByImgClick: true,
      preload: [0,1] // Will preload 0 - before current, and 1 after the current image
    },
    image: {
      tError: '<a href="%url%">The image #%curr%</a> could not be loaded.'
    },
    mainClass: 'overlay-main',
    tLoading: 'Loading image #%curr%...',
    type: 'image',
    zoom: {
      duration: 300, // duration of the effect, in milliseconds
      easing: 'ease-in-out', // CSS transition easing function
      enabled: true, // By default it's false, so don't forget to enable it
      // The "opener" function should return the element from which popup will be zoomed in
      // and to which popup will be scaled down
      // By defailt it looks for an image tag:
      opener: function(openerElement) {
        // openerElement is the element on which popup was initialized, in this case its <a> tag
        // you don't need to add "opener" option if this code matches your needs, it's defailt one.'
        console.log("openerElement", openerElement);
        console.log("openerElement is img?", openerElement.is('img'));
        return openerElement.is('img') ? openerElement : openerElement.find('img');
      }
    }
  });
});

// Agency Theme JavaScript

(function($) {
    "use strict"; // Start of use strict

    // jQuery for page scrolling feature - requires jQuery Easing plugin
    $('a.page-scroll').bind('click', function(event) {
        var $anchor = $(this);
        $('html, body').stop().animate({
            scrollTop: ($($anchor.attr('href')).offset().top - 50)
        }, 1250, 'easeInOutExpo');
        event.preventDefault();
    });

    // Highlight the top nav as scrolling occurs
    $('body').scrollspy({
        target: '.navbar-fixed-top',
        offset: 51
    });

    // Closes the Responsive Menu on Menu Item Click
    $('.navbar-collapse ul li a').click(function(){ 
      $('.navbar-toggle:visible').click();
    });

    // Offset for Main Navigation
    $('#main-nav').affix({
        offset: { top: 100 }
    })

})(jQuery); // End of use strict

