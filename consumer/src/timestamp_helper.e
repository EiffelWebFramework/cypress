note
	description: "Summary description for {TIMESTAMP_HELPER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TIMESTAMP_HELPER

inherit
	HTTP_DATE_TIME_UTILITIES

feature -- Access

	timestamp_now_utc: INTEGER_64
		do
			Result := unix_time_stamp (Void)
		end

end
