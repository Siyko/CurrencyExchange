# Need error fallbacks + possible long api request problem
class ExchangeRatesApi
  attr_reader :params
  URL_BASE = Rails.application.credentials[:exchange_rates_api_url_base]

  def initialize(params)
    @params = params
  end

  # Rename this if more options will apear(time range, convert etc)
  def call
    query_params = {
      base: params[:base_currency],
      symbols: params[:exchange_currency],
      start_at: params[:duration].to_i.days.ago.to_date.to_s, # remove this magic
      end_at: Date.today.to_s # this one too
    }.to_query

    url = "#{URL_BASE}/history?#{query_params}"

    self.class.fetch(url)
  end

  # add self.get_latest_rates. Need to save this to DB table or in cache somehow to avoid unnecessary queries to API
  # Caching is preferable, but i'm not sure how to do this properly
  def self.get_latest_rate base_currency, exchange_currency
    LatestRate.where(rate_date: Date.today, base_currency: base_currency, exchange_currency: exchange_currency).
      first_or_create do |r|
        url = "#{URL_BASE}/latest?base=#{base_currency}&symbols=#{exchange_currency}"

        r.rate = fetch(url).values.first
      end.rate # just decimal needed for now
  end

  private
  def self.fetch url
    uri = URI(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)

    #split this into 2 methods
    json = JSON.parse(response.body)
    raise 'Some error' if json.fetch('error', nil) # make this readable + loggable
    json.fetch('rates', nil)
  end
end
