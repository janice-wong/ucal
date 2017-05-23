class AddYelpToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :yelp, :string
  end
end
