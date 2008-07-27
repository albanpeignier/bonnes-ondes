class AddPrincipalToContent < ActiveRecord::Migration
  def self.up
    add_column :contents, :principal, :boolean

    Content.reset_column_information
    Content.update_all :principal => true
  end

  def self.down
    remove_column :contents, :principal
  end
end
