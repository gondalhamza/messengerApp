module CallbacksHelper
  def conversation
  	Message.all
  end

  def users
  	Person.where.not(first_name: "Admin")
  end
end
