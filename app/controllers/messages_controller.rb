class MessagesController < ApplicationController
  include Spree::Core::ControllerHelpers::Auth
  skip_before_action :authenticate_user!
  
  
  
  def new
    @subject = params[:subject]
    @message = Message.new
    render layout: 'porthos'
  end
  
  
  def create
    @message = Message.new(message_params)
    
    if @message.valid?
      MessageMailer.new_message(@message).deliver_now
      redirect_to redirect_location, notice: "Your message has been sent."
      
    else
      flash[:alert] = "An error occurred while delivering this message."
      render 'storefront/index'
    end
  end
  
  
  private
    def message_params
      params.require(:message).permit(:name, :email, :phone, :content, :subject)
    end
    
    def redirect_location
      if message_params[:subject].present?
        contact_path
      else
        root_path(anchor: 'contact')
      end
    end
    
    def render_location
      message_params[:subject].present? ? :new : 'storefront/index'
    end
  
end
