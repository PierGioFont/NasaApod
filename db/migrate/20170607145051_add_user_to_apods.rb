class AddUserToApods < ActiveRecord::Migration[5.0]
  def change
    add_reference :apods, :user, foreign_key: true
  end
end
