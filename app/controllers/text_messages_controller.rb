class TextMessagesController < ApplicationController
  def new
  end

  def create
    TextMessage.new(params[:number_to_send_to], "Hello Louis").send
  end
end
