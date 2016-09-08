module Features
  module FormHelpers
    @inquiries_form_default_message = "I'm very interested in some of your end table pieces. Would like to purchase in bulk but I'm Canada based ..."
    @inquiries_form_default_subject = 'Product Availability'
    
    def fill_text_fields(data)
      data.each do |key, val|
        fill_in key, with: val
      end
    end
    
    def fill_inquiries_form_with_valid_data(data={})
      default_data = {
        content: data[:content] || @inquiries_form_default_message,
        email: data[:email] || 'rickjames@cocaineisahellofadrug.com', 
        name: data[:name] || 'Dave Chappelle', 
        phone: data[:phone] || '212-345-5559'
      }
      
      # Will use passed in :subject value as long as it's not nil or empty string.
      # Otherwise @inquiries_form_default_subject value is used. In other words, 
      # the only way to omit selecting from down is to exclude the :subject key altogether. 
      # This should be done to test the short form.
      if data.has_key?(:subject)
        default_data[:subject] = data[:subject].present? ? data[:subject] : @inquiries_form_default_subject
      end
      
      select_inquiry_form_subject(default_data.delete(:subject))
      fill_text_fields(default_data)
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
