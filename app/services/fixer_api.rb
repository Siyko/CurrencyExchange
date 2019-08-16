class FixerApi
  attr_reader :params
  URL_BASE = Rails.application.credentials[:fixer_api_url_base]
  SECRET = Rails.application.credentials[:fixer_api_access_key]

  def initialize(params)
    @params = params
  end

  # Rename this if more options will apear(time range, convert etc)
  def call
    query_params = {
      access_key: SECRET,
      base: params[:base_currency],
      symbols: params[:exchange_currency]
    }.to_query

    url = "#{URL_BASE}/#{params[:exchange_date]}?#{query_params}"

    # Extract this to method
    uri = URI(url)
    http = Net::HTTP.new(uri.host, 80)
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)

    json = JSON.parse(response.body)
    raise 'Some error' if json.fetch('error', nil) # make this readable + loggable
    json.fetch('rates', nil)
  end

  # add self.get_latest_rates. Need to save this to DB table or in cache somehow to avoid unnecessary queries to API
  # Caching is preferable, but i'm not sure how to do this properly
end
