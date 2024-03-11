class AddIndexToNodes < ActiveRecord::Migration[7.0]
  def up
    add_index :nodes, :parent_id
  end

  def down
    remove_index :nodes, :parent_id
  end
end
