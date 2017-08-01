class AddRouteIdToTimmings < ActiveRecord::Migration[5.1]
  def change
    add_column :timmings, :route_id, :integer
  end
end
