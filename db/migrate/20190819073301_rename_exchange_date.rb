class RenameExchangeDate < ActiveRecord::Migration[5.2]
  def change
    remove_column :exchanges, :exchange_date
    add_column :exchanges, :duration, :integer
  end
end
