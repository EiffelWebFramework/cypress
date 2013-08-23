note
	description: "Objects that represent an OAUTH verifier"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	OAUTH_VERIFIER

create
	make

feature {NONE} --Initialization

	make (a_value: like value)
		do
			value := a_value
		ensure
			value_set: value = a_value
		end

feature -- Access

	value: READABLE_STRING_GENERAL

end
