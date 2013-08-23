note
	description: "Summary description for {OAUTH_10_VIMEO_API}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	OAUTH_10_VIMEO_API

inherit

	OAUTH_10_TEMPLATE_API

feature {NONE} -- Implementation


	Authorize_url: STRING = "http://vimeo.com/oauth/authorize?oauth_token="
	Request_token_endpoint_url: STRING = "http://vimeo.com/oauth/request_token"
	Access_token_endpoint_url: STRING = "http://vimeo.com/oauth/access_token"

end
