module Tourico
  class Api

    def initialize

    end

    def get_list(args, options = {:is_proxy => true})
      services(:search_hotels, args, options)
    end

    def get_list_by_hotel(args, options = {:is_proxy => true})
      services(:search_hotels_by_id, args, options)
    end

    def get_hotel_details(args, options = {:is_proxy => true})
      services(:get_hotel_details_v3,args,options)
    end

    def get_cancellation_policy(args, options = {:is_proxy => true})
      services(:get_cancellation_policies, args, options)
    end

    def book_hotel_v3(args, options = {:is_proxy => true})
      services(:book_hotel_v3,args,options)
    end

    def book_hotel_v3_with_retry(args,try_count = 1, options = {:is_proxy => true})
      supplier_response = ''
      try_count.times do
        supplier_response = book_hotel_v3(args, options)
        itinerary_id = supplier_response[:book_hotel_v3_response][:book_hotel_v3_result][:res_group][:@rg_id] rescue ''
        if !itinerary_id.blank?
          break
        end
      end
      supplier_response
    end

    def get_cancellation_fee_for_reservation(args, options = {:is_proxy => true})
      services(:get_cancellation_fee, args, options)
    end

    def cancel_reservation(args, options = {:is_proxy => true})
      services(:cancel_reservation,args,options)
    end

    def check_availability_and_prices(args, options = {:is_proxy => true})
      services(:check_availability_and_prices,args,options)
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

    def services (action, args, options = {:is_proxy => true})
      reservations_services = [:get_cancellation_policies, :get_previous_RG,:get_cancellation_fee,:cancel_reservation]
      hotel_services = [:search_hotels,:search_hotels_by_id,:get_hotel_details_v3,:book_hotel_v3, :check_availability_and_prices]

      if reservations_services.include?(action)
        return HTTPService.make_request_reservation_service(action, args, options)
      end

      if hotel_services.include?(action)
        return HTTPService.make_request(action, args, options)
      end

    end

  end
end