note
	description: "Summary description for {OAUTH_10_XING_API}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	OAUTH_10_XING_API

inherit

	OAUTH_10_TEMPLATE_API

feature {NONE} -- Implementation


	Authorize_url: STRING = "https://api.xing.com/v1/authorize?oauth_token="
	Request_token_endpoint_url: STRING = "https://api.xing.com/v1/request_token"
	Access_token_endpoint_url: STRING = "https://api.xing.com/v1/access_token"

end
