# Abstract factory implementation
class AbstractApi
  attr_reader :params, :api_factory
  def initialize(params = {}, api_factory = nil)
    @params = params
    @api_factory = api_factory
  end

  # make more methods if more options will appear, or pass method to #call as argument
  def call
    raise 'Api is not implemented' if api_factory.nil?
    api_factory.new(params).call
  end
end
