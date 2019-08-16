class AddApiResponseToExchange < ActiveRecord::Migration[5.2]
  def change
    add_column :exchanges, :api_response, :json
  end
end
