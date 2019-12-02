note
	description: "[
		Object to hold Proof Key for Code Exchange by OAuth Public Clients
		code challenge, code challenge method and code verifier.
	]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=rfc7636","src=https://tools.ietf.org/html/rfc7636", "protocol=uri"

class
	PKCE

create
	make_plain, make_sha256

feature -- {NONE}

	make_plain
				-- Create an instance with plain code challenge.
		do
			code_challenge := ""
			code_verifier := ""
			create {PKCE_CODE_CHALLENGE_METHOD_PLAIN} code_challenge_method
		ensure
			code_challenge_empty_set: code_challenge.is_empty
			code_verifier_empty_set: code_verifier.is_empty
			tranform_method_plain: attached {PKCE_CODE_CHALLENGE_METHOD_PLAIN} code_challenge_method
		end

	make_sha256
				-- Create an instance with sha256 code challenge,
		do
			code_challenge := ""
			code_verifier := ""
			create {PKCE_CODE_CHALLENGE_METHOD_SHA256} code_challenge_method
		ensure
			code_challenge_empty_set: code_challenge.is_empty
			code_verifier_empty_set: code_verifier.is_boolean
			tranform_method_sha256: attached {PKCE_CODE_CHALLENGE_METHOD_SHA256} code_challenge_method
		end

feature -- Access

	code_challenge: STRING
			-- code challenge derived from code verifier.

	code_verifier:  STRING
			-- code verifier.

	code_challenge_method: PKCE_CODE_CHALLENGE_METHOD
			 -- Code verifier transformation method is "S256" or "plain".


feature -- Status Report

	is_sha256: BOOLEAN
			-- Is the transformation method `SHA256`?
		do
			Result := attached {PKCE_CODE_CHALLENGE_METHOD_SHA256} code_challenge_method
		end

feature -- Change Element

	set_code_challenge (a_challenge: STRING)
			-- Set `code_challenge` with `a_challenge`.
		do
			code_challenge := a_challenge
		ensure
			code_challenge_set: code_challenge = a_challenge
		end

	set_code_verifier (a_verifier: STRING)
			-- Set `code_challenge` with `a_verifier`.
		do
			code_verifier := a_verifier
		ensure
			code_verifier_set: code_verifier = a_verifier
		end

	set_code_challenge_method (a_method: PKCE_CODE_CHALLENGE_METHOD)
			-- Set `code_challenge_method` with `a_method`.
		do
			code_challenge_method := a_method
		ensure
			code_challenge_method_set: code_challenge_method = a_method
		end


;note
	copyright: "2013-2019, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
