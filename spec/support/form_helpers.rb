module Features
  module FormHelpers
    
    def fill_text_fields(data)
      data.each do |key, val|
        fill_in key, with: val
      end
      # select_subject(data[:subject])
#       fill_in 'name',    with: data[:name]      if data[:name]
#       fill_in 'email',   with: data[:email]     if data[:email]
#       fill_in 'phone',   with: data[:phone]     if data[:phone]
#       fill_in 'content', with: data[:content]   if data[:content]
    end
    
    def fill_inquiries_form_with_valid_data(data)
      data = {
        content: "I'm very interested in some of your end table pieces. Would like to purchase in bulk but I'm Canada based",
        email: 'rickjames@cocaineisahellofadrug.com', 
        name: 'Dave Chappelle', 
        phone: '212-345-5559',
        subject: data[:subject] || 'Product Availability'
      }
      select_inquiry_form_subject(data.delete(:subject))
      fill_text_fields(data)
    end
    
    # Dropdown on this form is Bootstrap select so it's a pain to simulate (DOM hidden field)
    def select_inquiry_form_subject(subj)
      return unless subj
      find('button.dropdown-toggle', text: 'Regarding (Choose One)*').click
      find('ul.dropdown-menu span.text', text: subj).click
    end
    
  end
end
