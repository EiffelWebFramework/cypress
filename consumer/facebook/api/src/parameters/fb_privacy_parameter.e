note
	description: "[
					Object representing the privacy settings of the post. If not supplied, this defaults to the privacy level granted to the app in the Login Dialog. 
					This field cannot be used to set a more open privacy setting than the one granted.
					]"
	date: "$Date$"
	revision: "$Revision$"

class
	FB_PRIVACY_PARAMETER


feature -- Access

	value: detachable STRING
			-- The value of the privacy setting.
		    -- enum{'EVERYONE', 'ALL_FRIENDS', 'FRIENDS_OF_FRIENDS', 'CUSTOM', 'SELF'}

	allow: detachable LIST [STRING]
		-- When value is CUSTOM, this is a comma-separated list of user IDs and friend list IDs that can see the post.
		-- This can also be ALL_FRIENDS or FRIENDS_OF_FRIENDS to include all members of those sets.

	deny:  detachable LIST [STRING]
		-- When value is CUSTOM, this is a comma-separated list of user IDs and friend list IDs that cannot see the post.

feature -- Element Change

	set_value (a_val: like value)
			-- Set `value' with `a_val'.
			--| todo check if the value is a valid value.
		do
			value := a_val
		ensure
			value_set: value = a_val
		end

	set_allow (a_val: like allow)
			-- Set `allow' with `a_val'.
		do
			allow := a_val
		ensure
			allow_set: allow = a_val
		end

	set_deny (a_val: like deny)
			-- Set `deny' with `a_val'.
		do
			deny := a_val
		ensure
			deny_set: deny = a_val
		end
end
