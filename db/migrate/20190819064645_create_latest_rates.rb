class CreateLatestRates < ActiveRecord::Migration[5.2]
  def change
    create_table :latest_rates do |t|

      t.timestamps
      t.integer :base_currency
      t.integer :exchange_currency
      t.decimal :rate
      t.date :rate_date
    end
  end
end
