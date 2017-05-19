class ChangeGroupColumnDefault < ActiveRecord::Migration[5.0]
  def change
    change_column :groups, :share_cal, :boolean, default: false
  end
end
