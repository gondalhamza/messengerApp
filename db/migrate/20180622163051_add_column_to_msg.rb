class AddColumnToMsg < ActiveRecord::Migration[5.1]
  def change
  	add_column :messages, :person_id, :integer
  end
end
