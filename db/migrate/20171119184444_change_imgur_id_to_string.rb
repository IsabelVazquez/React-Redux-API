class ChangeImgurIdToString < ActiveRecord::Migration[5.1]
  def change
    change_column :images, :imgur_id, :string
  end
end
