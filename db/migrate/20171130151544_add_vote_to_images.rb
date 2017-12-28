class AddVoteToImages < ActiveRecord::Migration[5.1]
  def change
    add_column :images, :upvotes, :integer, :default => 0
  end
end
