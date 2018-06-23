class CallbackController < ApplicationController
  def index
  	if params["hub.verify_token"] == "myCustomToken123"
  		render text: params["hub.challenge"]
  		puts "Iam Here================================================"
  	end
  	puts "Iam Here Now==============================================="
  	@history = nil
  	@admin = Person.admin
  	if params[:rsu]
  		@user = Person.find_by_id(params[:rsu])
  		@history = Message.where(senderId: @user.token).or(Message.where(recipientId: @user.token))
  	end
  end

  def send_message
  	puts "==============================="
  	puts "Sending"
  	send_to = params[:val]
  	send_from = Person.admin.token

  	puts responce = Bot.deliver({
		  recipient: {
		    id: send_to 
		  },
		  message: {
		    text: params[:text]
		  }
		}, access_token: ENV['ACCESS_TOKEN'])
  	
  	res = JSON.parse(responce)
  	puts user = Person.find_by_token(send_to)
  	puts mess = user.messages.create(senderId: send_from, recipientId: send_to, status: true, timestamp: Time.now.to_i.to_s, mid: res["message_id"], body: params[:text])
  end

  def chat
  	@history = nil
  	if params["page_name"]
  		@user = Person.find_by_id(params["page_name"])
  		@history = Message.where(senderId: @user.token).or(Message.where(recipientId: @user.token))
  	end
   	if request.xhr?
  		respond_to do |format|   
		  	format.js 
			end
		else
			redirect_to client_url
		end
  end

  def client
  end
end