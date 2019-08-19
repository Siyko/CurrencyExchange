class Exchange < ApplicationRecord
  belongs_to :user

  enum base_currency: %I[USD RUB EUR], _prefix: :base
  enum exchange_currency: %I[USD RUB EUR], _prefix: :exchange

  validates :base_currency, :exchange_currency, :duration, :amount, presence: true

  validates :amount, numericality: { greater_than: 0 }
end
