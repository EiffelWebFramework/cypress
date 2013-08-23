note
	description: "Summary description for {OAUTH_10_FLICKR_API}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=OAuth Flickr API", "src=http://www.flickr.com/services/api/auth.oauth.html",  "protocol=uri"

class
	OAUTH_10_FLICKR_API

inherit

	OAUTH_10_TEMPLATE_API
			redefine
--				request_token_verb,
--				access_token_verb
			end

feature -- Access

--	request_token_verb: READABLE_STRING_GENERAL
--		do
--			Result := "GET"
--		end

--	access_token_verb: READABLE_STRING_GENERAL
--		do
--			Result := "GET"
--		end

feature {NONE} -- Implementation

	authorize_url: STRING = "http://www.flickr.com/services/oauth/authorize?oauth_token="

	request_token_endpoint_url: STRING = "http://www.flickr.com/services/oauth/request_token"

	access_token_endpoint_url: STRING = "http://www.flickr.com/services/oauth/access_token"

end
