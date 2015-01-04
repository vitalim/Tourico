require 'savon'

module Tourico
  module HTTPService

    class << self
      def make_request(action, args, options = {})
        puts 'Making hotels request to Tourico'
        client = Savon.client do
	        if Tourico.proxy_url.present?
						proxy Tourico.proxy_url
          end
          if Tourico.digest_auth.present?
            digest_auth(Tourico.digest_auth[:username], Tourico.digest_auth[:password])
          end
          log Tourico.show_logs
          wsdl Tourico.hotel_service_link

          if HTTPService.apply_timeout?(action)
            open_timeout Tourico.open_timeout
            read_timeout Tourico.read_timeout
          end

          soap_header  'aut:AuthenticationHeader' => {
              'aut:LoginName' => Tourico.login_name,
              'aut:Password'  => Tourico.password,
              'aut:Culture'   => Tourico.culture,
              'aut:Version'   => Tourico.hotels_service_version
          }
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

      def make_request_reservation_service(action, args, options = {})
        puts 'Making reservations request to Tourico'
        client = Savon.client do
	        if Tourico.proxy_url.present?
		        proxy Tourico.proxy_url
            end
          digest_auth('proxy_user', 'r00merhas1t!')
	        log Tourico.show_logs
          wsdl Tourico.reservation_service_link
          soap_header  'web:LoginHeader' => {
		          'trav:username' => Tourico.login_name,
		          'trav:password' => Tourico.password,
		          'trav:culture'  => Tourico.culture,
		          'trav:version'  => Tourico.reservations_service_version
          }
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

      #apply api call timeout except for while checkout
      def apply_timeout?(action)
        (action.to_s == 'book_hotel_v3') ? false : true
      end

    end
  end
end
