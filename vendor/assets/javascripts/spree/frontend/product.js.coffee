Spree.ready ($) ->
  thumbnails = ($ '#product-images ul.thumbnails')

  Spree.addImageHandlers = ->
    ($ '#main-image').data 'selectedThumb', ($ '#main-image img').attr('src')
    thumbnails.find('li').eq(0).addClass 'selected'
    thumbnails.find('a').on 'click', (event) ->
      ($ '#main-image').data 'selectedThumb', ($ event.currentTarget).attr('href')
      ($ '#main-image').data 'selectedThumbId', ($ event.currentTarget).parent().attr('id')
      thumbnails.find('li').removeClass 'selected'
      ($ event.currentTarget).parent('li').addClass 'selected'
      false

    thumbnails.find('li').on 'mouseenter', (event) ->
      ($ '#main-image img').attr 'src', ($ event.currentTarget).find('a').attr('href')

    thumbnails.find('li').on 'mouseleave', (event) ->
      ($ '#main-image img').attr 'src', ($ '#main-image').data('selectedThumb')

  Spree.showVariantImages = (variantId) ->
    currentThumb = ($ '#' + ($ '#main-image').data('selectedThumbId'))
    if not currentThumb.hasClass('vtmb-' + variantId)
      console.log "adding selected class to ", 'li.tmb-' + variantId
      thumb = ($ 'li.tmb-' + variantId)
      thumb = ($ ($ '#product-images ul.thumbnails li:visible').eq(0)) unless thumb.length > 0
      newImg = thumb.find('a').attr('href')
      ($ '#product-images ul.thumbnails li').removeClass 'selected'
      thumb.addClass 'selected'
      ($ '#main-image img').attr 'src', newImg
      ($ '#main-image').data 'selectedThumb', newImg
      ($ '#main-image').data 'selectedThumbId', thumb.attr('id')

  Spree.updateVariantPrice = (variant) ->
    variantPrice = variant.data('price')
    ($ '.price.selling').text(variantPrice) if variantPrice
    
    
  Spree.updateVariantQtySelector = (variant) ->
    variantQty = variant.data('on-hand')
    console.log "count on hand: " + variantQty
    if variantQty
      ($ 'input#quantity').attr('max', variantQty)
    else
      # $.get("/products/count_on_hand/"+variantQty)

    
    
  Spree.updateVariantColorHeading = (variant) ->
    variantColorSize = variant.data('options')
    ($ 'span#color-size').text(variantColorSize) if variantColorSize

  Spree.disableCartForm = (variant) ->
    inStock = variant.data('in-stock')
    $('#add-to-cart-button').attr('disabled', !inStock)

  radios = ($ '#product-variants input[type="radio"]')

  if radios.length > 0
    selectedRadio = ($ '#product-variants input[type="radio"][checked="checked"]')
    console.log "About to call showVariantImages and displaying all thumbs"
    ($ 'li.vtmb').show()
    Spree.showVariantImages selectedRadio.attr('value')
    Spree.updateVariantPrice selectedRadio
    Spree.updateVariantQtySelector selectedRadio
    Spree.updateVariantColorHeading selectedRadio
    Spree.disableCartForm selectedRadio

    radios.click (event) ->
      console.log "About to call showVariantImages " + @value
      Spree.showVariantImages @value
      Spree.updateVariantPrice ($ this)
      Spree.updateVariantQtySelector($ this)
      Spree.updateVariantColorHeading ($ this)
      Spree.disableCartForm ($ this)

  Spree.addImageHandlers()