class CreateApods < ActiveRecord::Migration[5.0]
  def change
    create_table :apods do |t|
      t.string :copyright
      t.text :explan
      t.string :hdurl

      t.timestamps
    end
  end
end
