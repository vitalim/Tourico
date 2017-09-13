require 'savon'

module Tourico
  module HTTPService
    HOTEL_SERVICE_LINK = 'http://demo-hotelws.touricoholidays.com/HotelFlow.svc?wsdl'.freeze
    RESERVATION_SERVICE_LINK = 'http://demo-wsnew.touricoholidays.com/reservationsservice.asmx?wsdl'.freeze
    DESTINATION_SERVICE_LINK = 'http://destservices.touricoholidays.com/DestinationsService.svc?wsdl'.freeze
    class << self
      def make_request(action, args, settings)
        puts 'Making hotels request to Tourico'
        configuration = config
        apply_timeout = apply_timeout?(action)
        client = Savon.client do
          if configuration.proxy_url.present?
            proxy configuration.proxy_url
          end

          log configuration.show_logs
          wsdl HOTEL_SERVICE_LINK

          if apply_timeout
            open_timeout configuration.open_timeout
            read_timeout configuration.read_timeout
          end

          soap_header  'aut:AuthenticationHeader' => {
              'aut:LoginName' => settings.username,
              'aut:Password'  => settings.password,
              'aut:Culture'   => configuration.culture,
              'aut:Version'   => configuration.hotels_service_version
          }
          headers ({ 'Accept-Encoding' => 'gzip, deflate' })
          namespaces(
              'xmlns:env'  => 'http://schemas.xmlsoap.org/soap/envelope/',
              'xmlns:aut'  => 'http://schemas.tourico.com/webservices/authentication',
              'xmlns:hot'  => 'http://tourico.com/webservices/hotelv3',
              'xmlns:wsdl' => 'http://tourico.com/webservices/hotelv3',
              'xmlns:hot1' => 'http://schemas.tourico.com/webservices/hotelv3')
        end
        response = client.call(action, message: args)
        puts 'Finished request for Tourico'
        if response.success?
          response.to_hash
        else
          nil
        end
      end

      def make_request_reservation_service(action, args, settings)
        puts 'Making reservations request to Tourico'
        configuration = config
        apply_timeout = apply_timeout?(action)
        client = Savon.client do
          if configuration.proxy_url.present?
            proxy configuration.proxy_url
          end

	        log config.show_logs
          wsdl RESERVATION_SERVICE_LINK
          soap_header  'web:LoginHeader' => {
              'trav:username' => settings.username,
              'trav:password' => settings.password,
              'trav:culture'  => configuration.culture,
              'trav:version'  => configuration.reservations_service_version
          }
          headers ({ 'Accept-Encoding' => 'gzip, deflate' })
          namespaces(
              'xmlns:env'  => 'http://schemas.xmlsoap.org/soap/envelope/',
              'xmlns:web'  => 'http://tourico.com/webservices/',
              'xmlns:hot'  => 'http://tourico.com/webservices/',
              'xmlns:wsdl' => 'http://tourico.com/webservices/',
              'xmlns:trav' => 'http://tourico.com/travelservices/')
        end

        response = client.call(action, message: args)

        puts 'Finished request for Tourico'
        response.to_hash

      end

      def make_request_destination_service(action, args, settings)
        puts 'Making destination request to Tourico'
        configuration = config
        apply_timeout = apply_timeout?(action)
        client = Savon.client do
          if configuration.proxy_url.present?
            proxy configuration.proxy_url
          end

          log configuration.show_logs
          wsdl DESTINATION_SERVICE_LINK

          if apply_timeout
            open_timeout configuration.open_timeout
            read_timeout configuration.read_timeout
          end

          soap_header  'dat:LoginHeader' => {
              'dat:username' => settings.username,
              'dat:password'  => settings.password,
              'dat:culture'   => configuration.culture,
              'dat:version'   => configuration.destination_service_version
          }
          headers ({ 'Accept-Encoding' => 'gzip, deflate' })
          namespaces(
              'xmlns:env'  => 'http://schemas.xmlsoap.org/soap/envelope/',
              'xmlns:dat' => 'http://touricoholidays.com/WSDestinations/2008/08/DataContracts',
              'xmlns:wsdl' => 'http://touricoholidays.com/WSDestinations/2008/08/DataContracts'
          )
        end

        response = client.call(action, message: args)

        puts 'Finished request for Tourico'
        if response.success?
          response.to_hash
        else
          nil
        end
      end

      #apply api call timeout except for while checkout
      def apply_timeout?(action)
        (action.to_s == 'book_hotel_v3') ? false : true
      end

      def config
        Tourico.configuration
      end

    end
  end
end
