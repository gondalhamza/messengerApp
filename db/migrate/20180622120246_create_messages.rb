class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.string :senderId
      t.string :recipientId
      t.string :mid
      t.boolean :status
      t.string :timestamp
      t.string :body

      t.timestamps
    end
  end
end
