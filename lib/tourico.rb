require 'tourico/version'
require 'tourico/api'
require 'tourico/http_service'

module Tourico
  class << self
    attr_accessor :login_name, :password, :culture, :hotels_service_version, :reservations_service_version, :location_service_version

    # initializer with all the configuration values
    def setup
      yield self
    end

  end
end
