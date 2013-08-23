note
	description: "Summary description for {TOKEN_EXTRACTOR_20}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TOKEN_EXTRACTOR_20

inherit

	ACCESS_TOKEN_EXTRACTOR

feature -- Access

	extract (response: READABLE_STRING_GENERAL): detachable OAUTH_TOKEN
			-- Extracts the access token from the contents of an Http Response
		local
			l_token_index: INTEGER
			l_param_index: INTEGER
			l_extract: STRING_8
			l_decoded: STRING_32
		do
			if response.has_substring (Token_definition) then
				l_token_index := response.substring_index (Token_definition, 1)
				l_extract := response.substring (token_definition.count + 1, response.count).as_string_8
				l_param_index := l_extract.index_of (parameter_separator, 1)
				if l_param_index /= 0 then
					l_extract := l_extract.substring (1, l_param_index - 1)
				end
				l_decoded := (create {OAUTH_ENCODER}).decoded_string (l_extract)
				create Result.make_token_secret_response (l_decoded, empty_secret, response.as_string_8)
			end
		end

feature {NONE} -- Implementation

	TOKEN_DEFINITION: STRING = "access_token="

	EMPTY_SECRET: STRING = ""

	PARAMETER_SEPARATOR: CHARACTER = '&'
			-- TODO add code to extract refresh_token

end
