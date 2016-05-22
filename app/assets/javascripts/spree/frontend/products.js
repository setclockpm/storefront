
// Spree.ready(function($) {
//   var radios, selectedRadio;
//
//   Spree.showVariantImages = function(variantId) {
//     var currentThumb, newImg, thumb;
//     console.log("override getting triggered");
//
//     ($('li.vtmb')).show();
//     // ($('li.tmb-' + variantId)).show();
//     currentThumb = $('#' + ($('#main-image')).data('selectedThumbId'));
//     if (!currentThumb.hasClass('vtmb-' + variantId)) {
//       thumb = $(($('#product-images ul.thumbnails li:visible.vtmb')).eq(0));
//       if (!(thumb.length > 0)) {
//         thumb = $(($('#product-images ul.thumbnails li:visible')).eq(0));
//       }
//       newImg = thumb.find('a').attr('href');
//       ($('#product-images ul.thumbnails li')).removeClass('selected');
//       thumb.addClass('selected');
//       ($('#main-image img')).attr('src', newImg);
//       ($('#main-image')).data('selectedThumb', newImg);
//       return ($('#main-image')).data('selectedThumbId', thumb.attr('id'));
//     }
//   };
// });