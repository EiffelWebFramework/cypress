note
	description: "Summary description for {FACEBOOK_API}."
	date: "$Date$"
	revision: "$Revision$"

class
	FACEBOOK_API

create
	make

feature {NONE} -- Initialization

	make (a_access_token: READABLE_STRING_32)
		do
				-- Using access token access mode.
			access_token := a_access_token
		end

feature -- Reset

	reset
		do
			create access_token.make_empty
		end

feature -- Access

	access_token: STRING_32
			-- Twitter access token.

	http_status: INTEGER
		-- Contains the last HTTP status code returned.

	last_api_call: detachable STRING
		-- Contains the last API call.

	last_response: detachable OAUTH_RESPONSE
		-- Cointains the last API response.


feature -- Facebook: Get User

	show_user (a_user: READABLE_STRING_32; a_params: detachable FB_USER_PARAMETER): detachable STRING
		do
			if
				attached a_params and then
				attached a_params.parameters as l_parameters
			then
				api_get_call (facebook_url (a_user, l_parameters ), Void)
			else
				api_get_call (facebook_url (a_user, Void ), Void)
			end
			if
				attached last_response as l_response and then
				attached l_response.body as l_body
			then
				Result := l_body
			end
		end

feature -- Parameters Factory

	parameters (a_params: detachable STRING_TABLE [STRING] ): detachable ARRAY [detachable TUPLE [name: STRING; value: STRING]]
		local
			l_result: detachable ARRAY [detachable TUPLE [name: STRING; value: STRING]]
			l_tuple : detachable TUPLE [name: STRING; value: STRING]
			i: INTEGER
		do
			if attached a_params then
				i := 1
				create l_result.make_filled (Void, 1, a_params.count)
				across a_params as ic
				loop
					create l_tuple.default_create
					l_tuple.put (ic.key, 1)
					l_tuple.put (ic.item, 2)
					l_result.force (l_tuple, i)
					i := i + 1
				end
				Result := l_result
			end
		end

feature -- Error Report

	has_error: BOOLEAN
			-- Last api call raise an error?
		do
			if attached last_response as l_response then
				Result := l_response.status /= 200
			else
				Result := False
			end
		end

	error_message: STRING
			-- Last api call error message.
		require
			has_error: has_error
		do
			if
				attached last_response as l_response
			then
				if
					attached l_response.error_message as l_error_message
				then
					Result := l_error_message
				else
					Result := l_response.status.out
				end
			else
				Result := "Unknown Error"
			end
		end

feature {NONE} -- Implementation

	api_post_call (a_api_url: STRING; a_params: detachable STRING_TABLE [STRING])
			-- POST REST API call for `a_api_url'
		do
			internal_api_call (a_api_url, "POST", a_params)
		end

	api_get_call (a_api_url: STRING; a_params: detachable STRING_TABLE [STRING])
			-- GET REST API call for `a_api_url'
		do
			internal_api_call (a_api_url, "GET", a_params)
		end

	internal_api_call (a_api_url: STRING; a_method: STRING; a_params: detachable STRING_TABLE [STRING])
			-- Note at the moment we are using `user token` access mode.
		note
			EIS:"name=access token", "src=https://developers.facebook.com/docs/facebook-login/access-tokens", "protocol=uri"
		local
			request: OAUTH_REQUEST
			l_access_token, request_token: detachable OAUTH_TOKEN
			api_service: OAUTH_20_SERVICE
		do
				-- Initialization

			create api_service.make (create {OAUTH_20_FACEBOOK_API}, create {OAUTH_CONFIG}.make_default ("", ""))
				--| TODO improve cypress service creation procedure to make configuration optional.

			print ("%N===Facebook OAuth Workflow using OAuth access token for the owner of the application ===%N")
				--| TODO rewrite prints as logs

				-- Create the access token that will identifies the user making the request.
			create l_access_token.make_token_secret (access_token, "NOT_NEEDED")
				--| Todo improve access_token to create a token without a secret.

			if attached l_access_token as ll_access_token then
				print ("%NGot the Access Token!%N");

					--Now let's go and check if the request is signed correcty
				print ("%NNow we're going to verify our credentials...%N");
					-- Build the request and authorize it with OAuth.
				create request.make (a_method, a_api_url)
				add_query_string (request, a_params)
				api_service.sign_request (ll_access_token, request)
				if attached {OAUTH_RESPONSE} request.execute as l_response then
					last_response := l_response
				end
			end
			last_api_call := a_api_url.string
		end




	facebook_url (a_query: STRING; a_params: detachable STRING): STRING
			-- Twitter url for `a_query' and `a_parameters'
		require
			a_query_attached: a_query /= Void
		do
			Result := "https://graph.facebook.com/v2.9/" + a_query
			if attached a_params then
				Result.append_character ('?')
				Result.append (a_params)
			end
		ensure
			Result_attached: Result /= Void
		end

	url (a_base_url: STRING; a_parameters: detachable ARRAY [detachable TUPLE [name: STRING; value: STRING]]): STRING
			-- url for `a_base_url' and `a_parameters'
		require
			a_base_url_attached: a_base_url /= Void
		do
			create Result.make_from_string (a_base_url)
			append_parameters_to_url (Result, a_parameters)
		end

	append_parameters_to_url (a_url: STRING; a_parameters: detachable ARRAY [detachable TUPLE [name: STRING; value: STRING]])
			-- Append parameters `a_parameters' to `a_url'
		require
			a_url_attached: a_url /= Void
		local
			i: INTEGER
			l_first_param: BOOLEAN
		do
			if a_parameters /= Void and then a_parameters.count > 0 then
				if a_url.index_of ('?', 1) > 0 then
					l_first_param := False
				elseif a_url.index_of ('&', 1) > 0 then
					l_first_param := False
				else
					l_first_param := True
				end
				from
					i := a_parameters.lower
				until
					i > a_parameters.upper
				loop
					if attached a_parameters[i] as a_param then
						if l_first_param then
							a_url.append_character ('?')
						else
							a_url.append_character ('&')
						end
						a_url.append_string (a_param.name)
						a_url.append_character ('=')
						a_url.append_string (a_param.value)
						l_first_param := False
					end
					i := i + 1
				end
			end
		end

	add_query_string (request:OAUTH_REQUEST; a_params: detachable STRING_TABLE [STRING])
		do
			if attached a_params then
				across a_params as ic
				loop
					request.add_query_string_parameter (ic.key.as_string_8, ic.item)
				end
			end
		end

end

