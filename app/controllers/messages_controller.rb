class MessagesController < ApplicationController
  include Spree::Core::ControllerHelpers::Auth
  skip_before_action :authenticate_user!
  layout 'utility'
  
  
  def new
    @subject = params[:subject]
    @message = Message.new
  end
  
  
  def create
    @message = Message.new(message_params)
    
    if message_has_errors?
      Rails.logger.debug "message_params[:subject].present?: #{message_params[:subject].present?}"
      render_form_template
    else
      MessageMailer.new_message(@message).deliver_now
      redirect_to redirect_location, notice: "Your message has been sent."
    end

  end
  
  
  private
    def message_params
      params.require(:message).permit(:name, :email, :phone, :content, :subject)
    end
    
    # Returning flash content will cause this to evaluate to true
    def message_has_errors?
      return recaptcha_error_alert unless verify_recaptcha(model: @message)
      return standard_error_alert unless @message.valid?
      false
    end
    
    def redirect_location
      if message_params[:subject].present?
        contact_path
      else
        root_path(anchor: 'inquiries-card')
      end
    end
    
    def form_template
      Rails.application.routes.recognize_path(request.referer).map{|k,v| v }.join('/')
    end
    
    def render_form_template
      message_params[:subject].present? ? (render form_template) : (redirect_to root_path(anchor: 'inquiries-card'))
    end
    
    def recaptcha_error_alert
      if message_params[:subject].present?
        flash.now[:alert] = "reCAPTCHA not verified."
      else
        flash[:alert] = "reCAPTCHA not verified."
      end
    end
    
    def standard_error_alert
      if message_params[:subject].present?
        flash.now[:alert] = "An error occurred while delivering this message."
      else
        flash[:alert] = "An error occurred while delivering this message."
      end
    end
  
end
