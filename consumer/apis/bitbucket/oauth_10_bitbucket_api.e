note
	description: "Summary description for {OAUTH_10_BITBUCKET_API}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	OAUTH_10_BITBUCKET_API

inherit

	OAUTH_10_TEMPLATE_API

feature {NONE} -- Implementation

	authorize_url: STRING = "https://bitbucket.org/api/1.0/oauth/authenticate?oauth_token="

	access_token_endpoint_url: STRING = "https://bitbucket.org/api/1.0/oauth/access_token"

	request_token_endpoint_url: STRING = "https://bitbucket.org/api/1.0/oauth/request_token"
end
