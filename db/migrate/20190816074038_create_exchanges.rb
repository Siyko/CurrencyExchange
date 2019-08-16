class CreateExchanges < ActiveRecord::Migration[5.2]
  def change
    create_table :exchanges do |t|

      t.timestamps
      t.decimal :amount
      t.date :exchange_date
      t.integer :base_currency
      t.integer :exchange_currency
    end
  end
end
