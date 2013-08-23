note
	description: "Summary description for {OAUTH_10_DROPBOX_API}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	OAUTH_10_DROPBOX_API

inherit

	OAUTH_10_API

feature -- Access

	access_token_endpoint: READABLE_STRING_GENERAL
		do
			Result := "https://api.dropbox.com/1/oauth/access_token"
		end

	authorization_url (a_token: detachable OAUTH_TOKEN) : READABLE_STRING_GENERAL
		local
			l_result : STRING
		do
			l_result := "https://www.dropbox.com/1/oauth/authorize?oauth_token="
			if a_token /= Void then
				l_result.append(a_token.token.as_string_8)
			end
			Result := l_result
		end

	request_token_endpoint: READABLE_STRING_GENERAL
		do
			Result := "https://api.dropbox.com/1/oauth/request_token"
		end

end
