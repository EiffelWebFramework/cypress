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
		note
			eis: "name=Base64url Encoding without Padding", "src=https://tools.ietf.org/html/rfc7636#appendix-A", "protocol=uri"
		local
			l_cursor: STRING_ITERATION_CURSOR
		do
				--base64url
				--https://tools.ietf.org/html/rfc7636#appendix-A
			Result := base64_encoder.encoded_string (sha256_string (a_code_verifier))
			create l_cursor.make (Result)

			across
				l_cursor as lc
			loop
				if lc.item.is_equal ('+') then
					Result.put ('-', lc.target_index)
				end
				if lc.item.is_equal ('/') then
					Result.put ('_', lc.target_index)
				end
			end
			Result.prune_all_trailing ('=')
		end


feature {NONE} -- Implementaetion

	sha256_string (a_str: STRING): STRING
		do
			sha256.update_from_string (a_str)
				-- TODO
				-- in future versions
				-- use the feature sha256.digest_as_byte_string
			Result := digest_as_byte_string (sha256.digest)
			sha256.reset
		end

	sha256: SHA256
		once
			create Result.make
		end

	digest_as_byte_string (digest: SPECIAL [NATURAL_8] ): STRING_8
			-- Byte array string representation of a_digest.
		local
			l_digest: like digest
			index, l_upper: INTEGER
		do
			l_digest := digest
			create Result.make (l_digest.count // 2)
			from
				index := l_digest.lower
				l_upper := l_digest.upper
			until
				index > l_upper
			loop
				Result.extend (l_digest [index].to_character_8)
				index := index + 1
			end
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
