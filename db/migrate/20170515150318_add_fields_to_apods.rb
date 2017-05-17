class AddFieldsToApods < ActiveRecord::Migration[5.0]
  def change
    add_column :apods, :media_type, :string
    add_column :apods, :title, :text
    add_column :apods, :url, :string
    add_column :apods, :date, :datetime
  end
end
