note
	description: "[
		Object representing the person's friends
		
			{
			    "data": [],
			    "paging": {},
			    "summary": {}
			}
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FB_USER_FRIENDS


feature -- Access

	friends: detachable LIST [FB_USER]
			-- A list of User nodes.

	paging: detachable FB_PAGING
			--  pagination.

	summary: detachable FB_SUMMARY
		-- Aggregated information about the edge, such as counts.
		-- Specify the fields to fetch in the summary param (like summary=total_count).

feature -- Element Change

	set_friends (a_friends: like friends)
			-- Set `friends' with  `a_friends'.
		do
			friends := a_friends
		ensure
			friends_set: friends = a_friends
		end

	set_paging (a_paging: like paging)
			-- Set `paging' with `a_paging'.
		do
			paging := a_paging
		ensure
			paging_set: paging = a_paging
		end

	set_summary (a_summary: like summary)
			-- Set `summary' with `a_summary'.
		do
			summary := a_summary
		ensure
			summary_set: summary = a_summary
		end

feature -- Status Report

	basic_out: STRING
		do
			create Result.make_from_string ("FRIENDS:")
			Result.append (("%N"))
			if attached friends as l_friends then
				across l_friends as ic loop
					Result.append (ic.item.basic_out)
					Result.append ("%N")
				end
			end
			if attached paging as l_paging then
				Result.append (l_paging.basic_out)
			end
			if attached summary as l_summary then
				Result.append (l_summary.shout_out)
			end
		end
end
