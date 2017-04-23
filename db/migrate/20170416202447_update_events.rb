class UpdateEvents < ActiveRecord::Migration[5.0]
  def change
    remove_column :events, :start_date, :string
    remove_column :events, :end_date, :string
    remove_column :events, :start_time, :string
    remove_column :events, :end_time, :string
    add_column :events, :start, :datetime
    add_column :events, :end, :datetime
  end
end