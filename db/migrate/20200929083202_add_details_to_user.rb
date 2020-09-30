class AddDetailsToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :salary, :decimal, precision: 7, scale: 2
  end
end
