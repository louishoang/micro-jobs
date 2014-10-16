class TextMessagesController < ApplicationController
  def new
  end

  def create
    receiver = User.find(params[:user_id])
    sender = current_user

    body = text_message_params[:text]
    body = body + "\n\nYou've been messsaged by #{sender.user_name}."

    if receiver.phone_number
      TextMessage.new(receiver.phone_number, body).send
      redirect_to :back
    else
      flash[:notice] = "Receiver doesn't have a phone number"
      redirect_to :back
    end
  end

  def text_message_params
    params.require(:text_message).permit(:text)
  end
end
