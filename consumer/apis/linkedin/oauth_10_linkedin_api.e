note
	description: "Summary description for {OAUTH_10_LINKEDIN_API}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	OAUTH_10_LINKEDIN_API

inherit

	OAUTH_10_TEMPLATE_API

feature {NONE} -- Implementation

	authorize_url: STRING ="https://api.linkedin.com/uas/oauth/authenticate?oauth_token="

	request_token_endpoint_url: STRING = "https://api.linkedin.com/uas/oauth/requestToken"

	access_token_endpoint_url: STRING = "https://api.linkedin.com/uas/oauth/accessToken"

end
