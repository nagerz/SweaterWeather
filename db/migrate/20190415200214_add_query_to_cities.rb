class AddQueryToCities < ActiveRecord::Migration[5.2]
  def change
    add_column :cities, :query, :string
  end
end
