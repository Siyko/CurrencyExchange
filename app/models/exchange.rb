class Exchange < ApplicationRecord
  belongs_to :user

  enum base_currency: %I[USD UAH EUR], _prefix: :base
  enum exchange_currency: %I[USD UAH EUR], _prefix: :exchange

  validates :base_currency, :exchange_currency, :exchange_date, :amount, presence: true

  validates :amount, numericality: { greater_than: 0 }
end
