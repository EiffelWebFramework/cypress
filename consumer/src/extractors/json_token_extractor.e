note
	description: "Summary description for {JSON_TOKEN_EXTRACTOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_TOKEN_EXTRACTOR

inherit

	ACCESS_TOKEN_EXTRACTOR

feature -- Extractor

	extract (response: READABLE_STRING_GENERAL): detachable OAUTH_TOKEN
		local
			l_json_parser: JSON_PARSER
		do
			create l_json_parser.make_parser (response.as_string_8)
			if attached {JSON_OBJECT} l_json_parser.parse_object as l_object then
				if attached {JSON_STRING} l_object.item ("access_token") as l_value then
					create Result.make_token_secret_response (l_value.item, "", response.as_string_8)
				end
			end
		end

		--TODO add code to extract refresh_token

end
