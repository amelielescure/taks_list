class ChangeVisibleDateToTask < ActiveRecord::Migration
  def change
    rename_column :tasks, :visible_date, :postpone_date
  end
end
