note
	description: "Object representing code challenge sha256"
	date: "$Date$"
	revision: "$Revision$"

class
	PKCE_CODE_CHALLENGE_METHOD_SHA256

inherit

	PKCE_CODE_CHALLENGE_METHOD

	SHARED_BASE64

feature -- Accesz


	transform_code_challenge (a_code_verifier: STRING): STRING
		local
			l_str: STRING
		do
				--base64url
				--https://tools.ietf.org/html/rfc7636#appendix-A
			Result := base64_encoder.encoded_string (sha256_string (a_code_verifier))
			Result.replace_substring_all ("+", "-")
			Result.replace_substring_all ("/", "_")
			Result.prune_all_trailing ('=')
		end


feature {NONE} -- Implementaetion

	sha256_string (a_str: STRING): STRING
		do
			sha256.update_from_string (a_str)
			Result := sha256.digest_as_byte_string
			sha256.reset
		end


	sha256: SHA256
		once
			create Result.make
		end

note
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
