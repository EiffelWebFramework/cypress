note
	description: "Summary description for {OAUTH_10_YAHOO_API}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	OAUTH_10_YAHOO_API

inherit

	OAUTH_10_TEMPLATE_API


feature {NONE} --Implemantation

	Authorize_url: STRING = "https://api.login.yahoo.com/oauth/v2/request_auth?oauth_token="
	Request_token_endpoint_url: STRING = "https://api.login.yahoo.com/oauth/v2/get_request_token"
	Access_token_endpoint_url: STRING = "https://api.login.yahoo.com/oauth/v2/get_token"


end
