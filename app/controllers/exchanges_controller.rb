class ExchangesController < ApplicationController
  before_action :resource, only: [:edit, :update, :destroy, :show]

  skip_before_action :authenticate_user!

  #
  # Need to add decorator(Draper) to avoid ugly code in views and controllers
  # Decorated resource will have additional fields like 'rate', 'result' etc
  # Also it will add css style for profit/loss based on latest rates
  #
  def index
    @collection = Exchange.all
  end

  def new
    @resource = Exchange.new
  end

  def create
    @resource = Exchange.new(exchange_params)
    @resource.user_id = current_user.id

    # move this to ExchangeBuilder which will build whole resource
    # saving rates to json field in db to avoid queries
    @resource.api_response = AbstractApi.new(exchange_params, ExchangeRatesApi).call

    if @resource.save
      redirect_to @resource
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @resource.update(exchange_params)
      redirect_to @resource
    else
      render 'edit'
    end
  end

  def destroy
    @resource.destroy
    redirect_to exchanges_path
  end

  def csv_download
    # Tell Rack to stream the content
    headers.delete("Content-Length")

    # Don't cache anything from this generated endpoint
    headers["Cache-Control"] = "no-cache"

    # Tell the browser this is a CSV file
    headers["Content-Type"] = "text/csv"

    # Make the file download with a specific filename
    headers["Content-Disposition"] = "attachment; filename=\"example.csv\""

    # Don't buffer when going through proxy servers
    headers["X-Accel-Buffering"] = "no"

    # Set an Enumerator as the body
    self.response_body = body

    # Set the status to success
    response.status = 200
  end

  private
  def body
    Enumerator.new do |yielder|
      2000000.times do |num|
        yielder << CSV.generate_line([num, "yay"])
      end
    end
  end

  def exchange_params
    # maybe add merge to avoid ugly line #19
    params.require(:exchange).permit(:amount, :base_currency, :exchange_currency, :duration)
  end

  def resource
    @resource = Exchange.find(params[:id])
  end
end
