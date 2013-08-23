note
	description: "Summary description for {OAUTH_10_TUMBLR_API}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	OAUTH_10_TUMBLR_API

inherit

	OAUTH_10_TEMPLATE_API

feature {NONE}-- Implementation

	authorize_url: STRING = "https://www.tumblr.com/oauth/authorize?oauth_token"

	request_token_endpoint_url: STRING = "http://www.tumblr.com/oauth/request_token"

	access_token_endpoint_url: STRING = "http://www.tumblr.com/oauth/access_token"

end
