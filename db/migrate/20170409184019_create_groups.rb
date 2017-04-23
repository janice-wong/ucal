class CreateGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :groups do |t|
      t.string :name
      t.string :status
      t.boolean :share_cal

      t.timestamps
    end
  end
end
