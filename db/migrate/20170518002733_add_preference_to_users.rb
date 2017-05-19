class AddPreferenceToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :preference, :string
  end
end
