note
	description: "Summary description for {ASASNA_OAUTH_20_API_EXAMPLE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ASANA_OAUTH_20_API_EXAMPLE

create
	make

feature -- Access

	make
		local
			asana: OAUTH_20_ASANA_API
			config: OAUTH_CONFIG
			api_service: OAUTH_SERVICE_I
			request: OAUTH_REQUEST
			access_token: detachable OAUTH_TOKEN
			current_code: detachable STRING
			signature_type: OAUTH_SIGNATURE_TYPE
		do
			create config.make_default (api_key, api_secret)
			config.set_callback ("http://127.0.0.1:9090")

			create signature_type.make
			create asana
			api_service := asana.create_service (config)
			print ("%N===ASANA OAuth Workflow ===%N")
				-- Obtain the Authorization URL
			print ("%NFetching the Authorization URL...");
			if attached api_service.authorization_url (empty_token) as lauthorization_url then
				print ("%NGot the Authorization URL!%N");
				print ("%NNow go and authorize here:%N");
				print (lauthorization_url);
				print("%NAnd paste the authorization code here%N");
				io.read_line
			end
				access_token := api_service.access_token_post (empty_token, create {OAUTH_VERIFIER}.make (io.last_string))
				if attached access_token as l_access_token then
					print ("%NGot the Access Token!%N");
					print ("%N(Token: " + l_access_token.debug_output + " )%N");
					--Now let's go and ask for a protected resource!
					print ("%NNow we're going to access a protected resource...%N");
					create request.make ("GET", protected_resource_url)
					request.add_header ("Authorization", "Bearer " + l_access_token.token)
					api_service.sign_request (l_access_token, request)
					if attached {OAUTH_RESPONSE} request.execute as l_response then
						print ("%NOk, let see what we found...")
						print ("%NResponse: STATUS" + l_response.status.out)
						if attached l_response.body as l_body then
							print ("%NBody:" + l_body)
						end
					end
				end
		end

	authorization_code: detachable STRING
		local
			socket: NETWORK_STREAM_SOCKET
			callback_string, code: STRING
			code_index: INTEGER
		do
	    	create socket.make_server_by_port(9991)
			socket.listen(5)
			socket.set_timeout (10)
			socket.accept
			if attached socket.accepted as accepted_socket then
				print ("%N")
				from
					callback_string := ""
					accepted_socket.read_character
				until
					callback_string.has_substring ("%R%N%R%N")
				loop
					print (accepted_socket.last_character)
					callback_string.append (accepted_socket.last_character.out)
					if not callback_string.has_substring ("%R%N%R%N") then
						accepted_socket.read_character
					end
				end
				code_index := callback_string.substring_index ("code=", 1)
				if code_index > 0 then
					Result := callback_string.substring (code_index + 5, callback_string.substring_index (" ", code_index + 5) - 1)
					print ("code ---> '" + Result + "'%N")
				end
				accepted_socket.close
			end
			socket.close
		end

feature {NONE} -- Implementation

	api_key : STRING ="10269331439104"
	api_secret :STRING ="ca158039a3886cb943198ba1f76a694c"
	protected_resource_url : STRING = "https://app.asana.com/-/oauth_token"
	empty_token: detachable OAUTH_TOKEN;

note
	copyright: "2013-2014, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
