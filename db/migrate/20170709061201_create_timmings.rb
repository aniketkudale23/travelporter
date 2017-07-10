class CreateTimmings < ActiveRecord::Migration[5.1]
  def change
    create_table :timmings do |t|
      t.string :in
      t.integer :bus_type
      t.references :provider

      t.timestamps
    end
  end
end
