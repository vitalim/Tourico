module Tourico

  class << self
    attr_accessor :configuration

    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end
  end

  class Configuration
    attr_accessor :show_logs, :open_timeout, :read_timeout, :culture,
                  :hotels_service_version, :reservations_service_version,
                  :location_service_version, :proxy_url, :production

    def initialize
      @show_logs = false
      @open_timeout = 2
      @read_timeout = 10
      @culture = 'en_US'
      @hotels_service_version = '8.5'
      @reservations_service_version = '8.5'
      @location_service_version = '1'
      @proxy_url = ''
      @production = Rails.env.production?
    end
  end
end