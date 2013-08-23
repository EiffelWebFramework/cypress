note
	description: "Objects that represent an OAuth response"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	OAUTH_RESPONSE

create
	make

feature {NONE} --Initialization

	make (response: HTTP_CLIENT_RESPONSE)
		do
			http_response := response
			body := response.body
			status := response.status
			headers := response.headers
			status_message := response.status_line
			error_message := response.error_message
		ensure
			http_reponse_set: http_response = response
			headers_set: headers = response.headers
			status_set: status = response.status
			status_message_set: status_message = response.status_line
			error_message_set: error_message = response.error_message
		end

feature -- Access

	EMPTY: STRING = "";

	status: INTEGER

	status_message: detachable READABLE_STRING_8

	error_message: detachable READABLE_STRING_8

	body: detachable READABLE_STRING_8

	headers: LIST [TUPLE [READABLE_STRING_8, READABLE_STRING_8]]

feature {NONE} -- Implementation

	http_response: HTTP_CLIENT_RESPONSE

end
