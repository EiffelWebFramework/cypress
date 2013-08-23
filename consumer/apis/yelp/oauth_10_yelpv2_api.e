note
	description: "[
			API provider for 2-legged OAuth10a for Yelp API (version 2).
			]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Yelp APIv2", "src=http://www.yelp.com.au/developers/documentation/v2/authentication", "protocol=uri"
	
class
	OAUTH_10_YELPV2_API

inherit

	OAUTH_10_TEMPLATE_API

feature {NONE} -- Implementation

	authorize_url: STRING =""

	request_token_endpoint_url: STRING = ""

	access_token_endpoint_url: STRING = ""

end



