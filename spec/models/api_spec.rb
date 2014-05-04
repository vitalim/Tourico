require 'tourico'

describe Tourico::Api do

  it 'search by destination' do
    api = Tourico::Api.new
    args = {
        'hot:request' => {
            'hot1:Destination' => 'NYC',
            'hot1:CheckIn' => '2013-10-23',
            'hot1:CheckOut' => '2013-10-25',
            'hot1:RoomsInformation' => {
                'hot1:RoomInfo' => {
                    'hot1:AdultNum' => '2',
                    'hot1:ChildNum' => '0',
                }
            },
            'hot1:MaxPrice' => '0',
            'hot1:StarLevel' => '0',
            'hot1:AvailableOnly' => 'true'
        }
    }
    api.get_list(args).should_not be_nil
  end

  it 'search by hotel id' do
    api = Tourico::Api.new
    args = {
        'hot:request' => {
            'hot1:HotelIdsInfo' => {
                'hot1:HotelIdInfo' => '',
                :attributes! => {'hot1:HotelIdInfo' => {'id' => '1314802'}},
            },
            'hot1:CheckIn' => '2014-05-10',
            'hot1:CheckOut' => '2014-05-12',
            'hot1:RoomsInformation' => {
                'hot1:RoomInfo' => {
                    'hot1:AdultNum' => '2',
                    'hot1:ChildNum' => '0',
                }
            },
            'hot1:MaxPrice' => '0',
            'hot1:StarLevel' => '0',
            'hot1:AvailableOnly' => 'true'
        }
    }
    api.get_list_by_hotel(args).should_not be_nil
  end

  it 'get hotel details v3' do
    api = Tourico::Api.new
    args = {
        'hot:HotelIds' => {
            'hot:HotelID' => '',
            :attributes! => { 'hot:HotelID' => { 'id' => '1314802' } }
        }
    }

    api.get_hotel_details(args).should_not be_nil
  end

  it 'get cancellation policy' do
    api = Tourico::Api.new
    args = {
        #'web:nResID' => '',
        'web:hotelId' =>'2210',
        'web:hotelRoomTypeId' => '5437',
        'web:dtCheckIn' => '2013-08-28',
        'web:dtCheckOut' => '2013-08-29'
    }

    api.get_cancellation_policy(args).should_not be_nil
  end

  it'get_previous_reservations' do
    api = Tourico::Api.new
    args = {
        'web:bFutureOnly' => 'true'
    }

    api.get_previous_reservations(args).should_not be_nil
  end

  it 'book hotel v3' do
    api = Tourico::Api.new
    args = {
        'hot:request' => {
            'hot1:RecordLocatorId' => '0',
            'hot1:HotelId' => '1215560',
            'hot1:HotelRoomTypeId' => '1973855',
            'hot1:CheckIn' => '2013-09-23',
            'hot1:CheckOut' => '2013-09-25',
            'hot1:RoomsInfo' => {
                'hot1:RoomReserveInfo' => {
                    'hot1:RoomId' => '1',
                    'hot1:ContactPassenger' => {
                        'hot1:FirstName' => 'John',
                        'hot1:LastName' => 'Doe',
                    },
                    'hot1:Bedding' => '2,1',
                    'hot1:AdultNum' => '2',
                    'hot1:ChildNum' => '0',
                }
            },
            'hot1:PaymentType' => 'Obligo',
            'hot1:AgentRefNumber' => '13NA',
            'hot1:RequestedPrice' => '324.66',
            'hot1:DeltaPrice' => '3',
            'hot1:Currency' => 'USD',
            'hot1:isOnlyAvailable' => 'true'
        }
    }
    api.book_hotel_v3(args).should_not be_nil
  end

  it 'cancel reservation' do
    api = Tourico::Api.new
    args = {
        'web:nResID' => '37434386',
    }

    api.cancel_reservation(args).should_not be_nil
  end

  it 'get cancellation fee for reservation' do
    api = Tourico::Api.new
    args = {
        'web:nResID' => '37434386',
        'web:clxDate'  => '2013-08-26'
    }

    api.get_cancellation_fee_for_reservation(args).should_not be_nil

  end

  it 'check availability and prices' do
    api = Tourico::Api.new
    args = {
        'hot:request' => {
            'hot1:HotelIdsInfo'=> {
              'hot1:HotelIdInfo' => '',
              :attributes! => {'hot1:HotelIdInfo' => {'id' => '1215560'}}
            },
            'hot1:CheckIn' => '2014-10-23',
            'hot1:CheckOut' => '2014-10-25',
            'hot1:RoomsInformation' => {
                'hot1:RoomInfo' => {
                    'hot1:AdultNum' => '2',
                    'hot1:ChildNum' => '0',
                }
            },
            'hot1:MaxPrice' => '0',
            'hot1:StarLevel' => '0',
            'hot1:AvailableOnly' => 'true'
        }
    }
    api.check_availability_and_prices(args).should_not be_nil
  end
end