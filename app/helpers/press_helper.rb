module PressHelper
  
  def featured_in_images
    {
      "logos/external/bhg.png" => 'http://www.bhg.com/', 
      "logos/external/nbc.png" => 'http://www.nbc.com/shows/current', 
      "logos/external/wayfair.png" => 'http://www.wayfair.com/Porthos-Home-B40284.html',
      "logos/external/overstock.png" => 'http://www.overstock.com/Porthos-Home,/brand,/results.html', 
      "logos/external/houzz.png" => 'http://www.houzz.com/', 
      "logos/external/redbook.png" => 'http://www.redbookmag.com/', 
      "logos/external/hgtv.png" => 'http://www.hgtv.com/', 
      "logos/external/desert-trip.png" => 'http://deserttrip.com/'
    }
  end
  
  def featured_item_offset_class(pos)
    offset_cls = 'col-lg-2 col-md-3 col-sm-4 col-xs-6 grid-item'
    offset_cls += ' col-lg-offset-2' if pos % 4 == 0
    offset_cls += ' col-sm-offset-2 col-md-offset-0' if pos % 2 == 0
    offset_cls
  end
  
  def social_media_icons
    { facebook: 'https://facebook.com/porthoshome', pinterest: 'https://pinterest.com', twitter: 'https://twitter.com/porthoshome', instagram: "https://instagram.com" }
  end
  
end
