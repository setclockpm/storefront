class MessagesController < ApplicationController
  include Spree::Core::ControllerHelpers::Auth
  skip_before_action :authenticate_user!
  
  def create
    @message = Message.new(message_params)
    
    if @message.valid?
      MessageMailer.new_message(@message).deliver_now
      #redirect_to root_path(anchor: "contact"), notice: "Your message has been sent."
      redirect_to root_path, notice: "Your message has been sent."
      
    else
      flash[:alert] = "An error occurred while delivering this message."
      render 'storefront/index'
    end
  end
  
  
  private

    def message_params
      params.require(:message).permit(:name, :email, :phone, :content)
    end
  
end
