note
	description: "Signs a base string, returning the OAuth signature"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SIGNATURE_SERVICE

feature -- Access

	signature (base_string: READABLE_STRING_GENERAL; api_secret: READABLE_STRING_GENERAL; token_secret: READABLE_STRING_GENERAL): STRING_32
			-- Return a signature
			-- `base_string' url-encoded string to sign
			-- `api_secret' api secret for your app
			-- `token_secret' token secret (empty string for the request token step)
		require
			base_string_not_empty: not base_string.is_empty
			api_secret_not_empty : not api_secret.is_empty
		deferred
		end

	signature_method: STRING_32
			-- Return the signature algorithm
		deferred
		end
end
