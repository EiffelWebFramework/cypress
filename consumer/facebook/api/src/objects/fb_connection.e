note
	description: "Summary description for {FB_CONNECTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FB_CONNECTION [G]

--inherit

--	ITERATION_CURSOR [G]
--  ITERABLE [G]

create
	make

feature -- Initialization

	make (a_api: FACEBOOK_I)
		do
			api := a_api
			create {ARRAYED_LIST [G]}data.make (0)
		end

feature -- Access

	data:  LIST [G]
			-- A list of data nodes.

	paging: detachable FB_PAGING
			--  pagination.

	summary: detachable FB_SUMMARY
		-- Aggregated information about the edge, such as counts.
		-- Specify the fields to fetch in the summary param (like summary=total_count).


feature -- Element Change

	set_data (a_data: like data)
			-- Set `data' with  `a_data'.
		do
			data := a_data
		ensure
			data_set: data = a_data
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


feature -- Implementation

	api: FACEBOOK_I
			-- API interface.


end
