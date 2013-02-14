# IGolf

The iGolf client library allows users/members of iGolf to access iGolf's course, lists, GPS, vector and general reference data.

## Installation

Add this line to your application's Gemfile:

    gem 'igolf-client'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install igolf-client

Once installed, simply create an igolf-init.rb in your initializers folder containing the following

		IGolf.configure do |config|
		  config.application_api_key = "YOUR_KEY_GOES_HERE"
		  config.api_key = "YOUR_KEY_GOES_HERE" #if you are using private methods
		  config.application_secret_key = "YOUR_KEY_GOES_HERE"
		end

## Usage

To use the igolf-client gem simply add 

		require 'igolf-client'
		
to the top of your file and then call

	IGolf::get(ACTION_CODE, REQUEST_PAYLOAD)

Example:

	IGolf::get("CourseList", {"active": 1, "id_country": 1})
	
This will return all active courses in the United States.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
