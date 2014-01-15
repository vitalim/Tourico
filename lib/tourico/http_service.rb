require 'savon'

module Tourico
  module HTTPService

    class << self
       def make_request(action, args, options = {})
         puts 'Making request to Tourico'
         client = Savon::Client.new(Tourico.hotel_service_link)

         #client.log_level = :error

         response = client.request :hot, action do

           soap.namespaces['xmlns:env'] = 'http://schemas.xmlsoap.org/soap/envelope/'
           soap.namespaces['xmlns:aut'] = 'http://schemas.tourico.com/webservices/authentication'
           soap.namespaces['xmlns:hot'] = 'http://tourico.com/webservices/hotelv3'
           soap.namespaces['xmlns:hot1'] = 'http://schemas.tourico.com/webservices/hotelv3'

           soap.header = {
              'aut:AuthenticationHeader' => {
                'aut:LoginName' => Tourico.login_name,
                'aut:Password' => Tourico.password,
                'aut:Culture' => Tourico.culture,
                'aut:Version' => Tourico.hotels_service_version
              }
           }

           soap.body = args

         end
         puts 'Finished request for Tourico'
         if response.success?
             response.to_hash
         else
            nil
         end
       end

       def make_request_reservation_service(action, args, options = {})
         puts 'Making request to Tourico'
         client = Savon::Client.new(Tourico.hotel_service_link)

         response = client.request :hot, action do

           soap.namespaces['xmlns:env'] = 'http://www.w3.org/2003/05/soap-envelope'
           soap.namespaces['xmlns:web'] = 'http://tourico.com/webservices/'
           soap.namespaces['xmlns:hot'] = 'http://tourico.com/webservices/'
           soap.namespaces['xmlns:trav'] = 'http://tourico.com/travelservices/'

           soap.header = {
               'web:LoginHeader' => {
                   'trav:username' => Tourico.login_name,
                   'trav:password' => Tourico.password,
                   'trav:culture' => Tourico.culture,
                   'trav:version' => Tourico.reservations_service_version
               }
           }

           soap.body = args

         end
         puts 'Finished request for Tourico'
         response.to_hash

       end
    end
  end
end
