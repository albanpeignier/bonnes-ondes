class CreateContents < ActiveRecord::Migration
  def self.up
    create_table "contents" do |t|
      t.column :type, :string, :null => false
      t.column :name, :string, :null => false
      t.column :slug, :string, :null => false
      t.column :duration, :integer
      t.column :episode_id, :integer, :null => false
      
      t.column :created_at, :timestamp
      t.column :updated_at, :timestamp
      
      # for AudioBankSound
      t.column :audiobank_id, :string 
      # for NetSound
      t.column :url, :string
    end
  end

  def self.down
    drop_table "contents"
  end
end
