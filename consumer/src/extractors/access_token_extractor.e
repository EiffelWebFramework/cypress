note
	description: "Summary description for {ACCESS_TOKEN_EXTRACTOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ACCESS_TOKEN_EXTRACTOR

feature -- Extractor

	extract (response: READABLE_STRING_GENERAL): detachable OAUTH_TOKEN
			-- Extracts the access token from the contents of an Http Response
		require
			not_empty: not response.is_empty
		deferred
		end

end
