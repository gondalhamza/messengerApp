class Person < ApplicationRecord
	has_many :messages

	scope :admin, -> { where(first_name: "Admin").first }

	def full_name
		"#{self.first_name} #{self.last_name}"
	end
end
