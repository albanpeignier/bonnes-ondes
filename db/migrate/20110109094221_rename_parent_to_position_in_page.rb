class RenameParentToPositionInPage < ActiveRecord::Migration
  def self.up
    change_table :pages do |t|
      t.rename :parent_id, :position
    end
  end

  def self.down
    change_table :pages do |t|
      t.rename :position, :parent_id
    end
  end
end
