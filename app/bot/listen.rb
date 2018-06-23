require "facebook/messenger"
include Facebook::Messenger

require "execjs"
require "open-uri"


Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["ACCESS_TOKEN"])
Bot.on :message do |message|
  puts "got your message!"
  puts message.inspect
  if message.text.present?
	  begin
	  	responce = JSON.parse(message.to_json)
	  	puts user = Person.find_by_token(message.sender["id"])
	  	puts recipient = Person.find_by_token(message.recipient["id"])

	  	if user.nil?
	  		result = JSON.parse(HTTP.get("https://graph.facebook.com/v2.6/#{message.sender["id"]}?fields=first_name,last_name,profile_pic&access_token=#{ENV['ACCESS_TOKEN']}"))
	  		puts user = Person.create(first_name: result["first_name"], last_name: result["last_name"], token: result["id"], profile_pic: result["profile_pic"])
	  	end
	  	if recipient.nil?
	  	  pic_result = HTTP.get("https://graph.facebook.com/v2.6/#{message.recipient["id"]}/picture")["Location"]
	  	  Person.create(first_name: "Admin", last_name: "", token: message.recipient["id"], profile_pic: pic_result)
	  	end
		  mess = user.messages.create(senderId: message.sender["id"], status: true, recipientId: message.recipient["id"], timestamp: responce["messaging"]["timestamp"].to_s, mid: responce["messaging"]["message"]["mid"], body: message.text)
		  puts mess.inspect
	  	puts "------------------------------"
	  rescue
	  	puts "Exception->>>>>>>>>>>>>>>>>."
	  end
  else
  	puts "****"
  end
end