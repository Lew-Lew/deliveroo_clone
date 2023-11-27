class RenameColumnTypeInItems < ActiveRecord::Migration[7.1]
  def change
    rename_column :items, :type, :dishes_type
  end
end
