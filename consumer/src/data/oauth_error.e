note
	description: "Summary description for {OAUTH_ERROR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	OAUTH_ERROR

create
	make

feature {NONE} --Initialization

	make (a_description: like description)
		do
			description := a_description
		ensure
			description_set: description = a_description
		end

feature -- Access

	description: READABLE_STRING_GENERAL
			-- Error description

end
