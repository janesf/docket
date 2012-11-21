class ChangeTypeToEntities < ActiveRecord::Migration
  def change
    rename_column :entities, :type, :entitytype
  end
end
