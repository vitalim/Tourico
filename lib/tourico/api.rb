module Tourico
  class Api

    def initialize

    end

    def get_list(args)
      services(:search_hotels, args)
    end

    def get_hotel_details(args)
      services(:get_hotel_details_v3,args)
    end

    def get_cancellation_policy(args)
      services(:get_cancellation_policies, args)
    end

    def book_hotel_v3(args)
      services(:book_hotel_v3,args)
    end

    def get_cancellation_fee_for_reservation(args)
      services(:get_cancellation_fee, args)
    end

    def cancel_reservation(args)
      services(:cancel_reservation,args)
    end


    ## - not working
    def get_previous_reservations(args)
      services(:get_previous_RG, args)
    end

    def cost_amend(args)

    end

    def do_amend(args)

    end



    private

    def services (action, args)
      reservations_services = [:get_cancellation_policies, :get_previous_RG,:get_cancellation_fee,:cancel_reservation, :cost_amend,:do_amend]
      hotel_services = [:search_hotels,:get_hotel_details_v3,:book_hotel_v3]

      if reservations_services.include?(action)
        return HTTPService.make_request_reservation_service(action, args)
      end

      if hotel_services.include?(action)
        return HTTPService.make_request(action, args)
      end

    end

  end
end