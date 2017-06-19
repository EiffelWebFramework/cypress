note
	description: "Summary description for {LOGIN_WITH_GITHUB_SERVICE}."
	date: "$Date$"
	revision: "$Revision$"

class
	LOGIN_WITH_GITHUB_SERVICE

create
	make

feature {NONE} -- Initialization

	make
		do
			create config.make_default (api_key, api_secret)
			config.set_callback ("SET_YOUR_CALLBACK")
			config.set_scope (scope)
			create github
			api_service := github.create_service (config)
		end

feature -- Authorization

	authorization_url: detachable STRING_8
		do
			Result := api_service.authorization_url (Void)
		end

	sign_request (a_code: READABLE_STRING_32)
			-- Sign request with code `a_code'.
			--! To get the code `a_code' you need to do a request
			--! using the authorization_url
		local
			request: OAUTH_REQUEST
		do
			oauth_response := Void
				-- Get the access token.
			access_token := api_service.access_token_post (Void, create {OAUTH_VERIFIER}.make (a_code))
			if attached access_token as l_access_token then
				create request.make ("GET", protected_resource_url)
				request.add_header ("Authorization", "Bearer " + l_access_token.token)
				request.add_header ("User-Agent", "EiffelWeb Login with Github") --Required by Github API.
				api_service.sign_request (l_access_token, request)
				if attached {OAUTH_RESPONSE} request.execute as l_response then
					oauth_response := l_response
					if attached l_response.body as l_body then
						response := l_body
					end
				end
			end
		end

feature {NONE} -- Implementation

	github: OAUTH_20_GITHUB_API

	config: OAUTH_CONFIG

	api_service: OAUTH_SERVICE_I

	api_key: STRING = "YOU_API_KEY"

	api_secret: STRING = "YOU_API_SECRET"

	scope: STRING = "user,repo,public_repo"

	oauth_response: detachable OAUTH_RESPONSE

feature -- Access

	access_token: detachable OAUTH_TOKEN
			-- JSON representing the access token.


	protected_resource_url: STRING = "https://api.github.com/user"
			-- Resource URL

	response: detachable READABLE_STRING_32
			-- Last API call response


	status: INTEGER
			-- HTTP status error.
		do
			if attached oauth_response as l_response then
				Result := l_response.status
			else
				Result := 500
				 -- Internal Server Error
			end
		end

	user: detachable STRING_32
		do
			if attached response as l_response then
				Result := string32_value_from_json (parsed_json (l_response), "login")
			end

		end

feature {NONE} --Implementation

	string32_value_from_json (a_json_data: detachable JSON_VALUE; a_id: STRING): detachable STRING_32
		do
			if attached {JSON_STRING} json_value (a_json_data, a_id) as v then
				Result := v.unescaped_string_32
			end
		end


	last_json: detachable JSON_VALUE

	parsed_json (a_json_text: STRING): detachable JSON_VALUE
		local
			j: JSON_PARSER
		do
			create j.make_with_string (a_json_text)
			j.parse_content
			Result := j.parsed_json_value
			last_json := Result
		end

	json_value (a_json_data: detachable JSON_VALUE; a_id: STRING): detachable JSON_VALUE
		local
			l_id: JSON_STRING
			l_ids: LIST [STRING]
		do
			Result := a_json_data
			if Result /= Void then
				if a_id /= Void and then not a_id.is_empty then
					from
						l_ids := a_id.split ('.')
						l_ids.start
					until
						l_ids.after or Result = Void
					loop
						create l_id.make_from_string (l_ids.item)
						if attached {JSON_OBJECT} Result as v_data then
							if v_data.has_key (l_id) then
								Result := v_data.item (l_id)
							else
								Result := Void
							end
						else
							Result := Void
						end
						l_ids.forth
					end
				end
			end
		end


end
