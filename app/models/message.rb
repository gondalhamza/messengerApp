class Message < ApplicationRecord
	belongs_to :person

	def belongs_to_admin?
		self.senderId.eql? Person.find_by_first_name("Admin").token
	end
end
