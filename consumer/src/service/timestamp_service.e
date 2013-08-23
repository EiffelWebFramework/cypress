note
	description: " Unix epoch timestamp generator."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TIMESTAMP_SERVICE


feature
	timestamp_in_seconds: STRING
			-- unix epoch timestamp in seconds
		deferred
		end

	nonce:STRING
			-- unique value for each request
		deferred
		end

end
