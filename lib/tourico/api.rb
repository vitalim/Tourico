module Tourico
  class Api

    def initialize

    end

    def get_list(args)
      services(:search_hotels, args)
    end

    def get_list_by_hotel(args)
      services(:search_hotels_by_id, args)
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

    def book_hotel_v3_with_retry(args,try_count = 1)
      supplier_response = ''
      try_count.times do
        supplier_response = book_hotel_v3(args)
        itinerary_id = supplier_response[:book_hotel_v3_response][:book_hotel_v3_result][:res_group][:@rg_id] rescue ''
        if !itinerary_id.blank?
          break
        end
      end
      supplier_response
    end

    def get_cancellation_fee_for_reservation(args)
      services(:get_cancellation_fee, args)
    end

    def cancel_reservation(args)
      services(:cancel_reservation,args)
    end

    def check_availability_and_prices(args)
      services(:check_availability_and_prices,args)
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
      reservations_services = [:get_previous_RG]
      hotel_services = [:search_hotels,:search_hotels_by_id,:get_hotel_details_v3,:book_hotel_v3, :check_availability_and_prices,:get_cancellation_policies,:get_cancellation_fee,:cancel_reservation]

      if reservations_services.include?(action)
        return HTTPService.make_request_reservation_service(action, args)
      end

      if hotel_services.include?(action)
        return HTTPService.make_request(action, args)
      end

    end

  end
end