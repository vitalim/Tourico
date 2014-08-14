require 'tourico/version'
require 'tourico/api'
require 'tourico/http_service'

module Tourico
  class << self
    attr_accessor :login_name, :password, :culture, :hotels_service_version, :reservations_service_version, :location_service_version,:hotel_service_link,:reservation_service_link,:sandbox, :show_logs, :proxy_url

    # initializer with all the configuration values
    def setup
      self.sandbox = true
      self.hotel_service_link = 'http://demo-hotelws.touricoholidays.com/HotelFlow.svc?wsdl'
      self.reservation_service_link = 'http://demo-wsnew.touricoholidays.com/reservationsservice.asmx?wsdl'
      self.show_logs = false
      yield self

      # Savon.configure do|config|
      #   config.log = false
      # end
    end

  end
end
