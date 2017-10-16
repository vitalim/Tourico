# Tourico

Tourico gem is a ruby wrapper for Tourico API Affiliate Network

## Installation

Add this line to your application's Gemfile:

    gem 'tourico'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tourico

## Usage

If you need proxy:

Create initializers/tourico.rb

    Tourico.proxy_url = '' # your proxy url

## Sample
    class SupplierSettings
        attr_accessor :username, :password    
    end
    supplier_settings = SupplierSettings.new(username: '', password: '') # your credentials
    client = Tourico::Api.new(supplier_settings)
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
    response = client.get_list(args)


All the other samples could be found inside the Rspec directory:
spec/models/api_spec.rb


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
