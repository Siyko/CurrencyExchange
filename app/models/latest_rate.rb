class LatestRate < ApplicationRecord
  enum base_currency: %I[USD RUB EUR], _prefix: :base
  enum exchange_currency: %I[USD RUB EUR], _prefix: :exchange
end
