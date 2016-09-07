module Features
  module FormHelpers
    @inquiries_form_default_message = "I'm very interested in some of your end table pieces. Would like to purchase in bulk but I'm Canada based ..."
    
    def fill_text_fields(data)
      data.each do |key, val|
        fill_in key, with: val
      end
    end
    
    def fill_inquiries_form_with_valid_data(data)
      data = {
        content: data[:content] || @inquiries_form_default_message,
        email: data[:email] || 'rickjames@cocaineisahellofadrug.com', 
        name: data[:name] || 'Dave Chappelle', 
        phone: data[:phone] || '212-345-5559',
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
    
    # This is not being used quite yet
    def select_from_bootstrap_select(data)
      find('button.dropdown-toggle', text: data[:prompt_text]).click
      find('ul.dropdown-menu span.text', text: data[:selection_text]).click
    end
    
  end
end
