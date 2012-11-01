class ChangeColumnNameOfUsers < ActiveRecord::Migration
  def up
    rename_column :users, :avtar, :image
  end

  def down
    rename_column :users, :image, :avtar
  end
end
