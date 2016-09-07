module Features
  module FormHelpers
    
    def fill_inquiry_form_text_fields(field_entries={})
      select_subject(field_entries[:subject]) if field_entries[:subject]
      fill_in 'name', with: field_entries[:name] || 'Dave Chappelle'
      fill_in 'email', with: field_entries[:email] || 'rickjames@cocaineisahellofadrug.com'
      fill_in 'phone', with: field_entries[:phone] || '212-345-5559'
      fill_in 'content', with: field_entries[:content] || "I'm very interested in some of your end table pieces. Would like to purchase in bulk but I'm Canada based"
    end
    
    # Dropdown on this form is Bootstrap select so it's a pain to simulate (DOM hidden field)
    def select_subject(subj='Wholesale Inquiries')
      find('button.dropdown-toggle', text: 'Regarding (Choose One)*').click
      find('ul.dropdown-menu span.text', text: subj).click
    end
    
  end
end
