class AddPubToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :pub, :boolean
  end

  def self.down
    remove_column :users, :pub
  end
end
