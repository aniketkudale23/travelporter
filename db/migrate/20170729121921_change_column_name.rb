class ChangeColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :timmings, :in, :dept_time
  end
end
