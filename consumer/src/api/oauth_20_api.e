note
	description: "Summary description for {OAUTH_20_API}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	OAUTH_20_API

inherit

	OAUTH_API

feature -- Access

	access_token_extractor: ACCESS_TOKEN_EXTRACTOR
		do
			create {TOKEN_EXTRACTOR_20} Result
		end

	access_token_verb: READABLE_STRING_GENERAL
		do
			Result := "GET"
		end

	access_token_endpoint: READABLE_STRING_GENERAL
			-- Url that receives the access token request
		deferred
		end

	authorization_url (config: OAUTH_CONFIG): detachable READABLE_STRING_GENERAL
			-- Url where you should redirect your users to authneticate
		deferred
		end

feature -- Service

	create_service (config: OAUTH_CONFIG): OAUTH_SERVICE_I
		do
			create {OAUTH_20_SERVICE} Result.make (Current, config)
		end

note
	copyright: "2013-2013, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
