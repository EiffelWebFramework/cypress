note
	description: "Summary description for {FACEBOOK_JSON}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FACEBOOK_JSON

inherit

	FACEBOOK_I
		redefine
			default_create
		select
			default_create
		end

	REFACTORING_HELPER
		rename
			default_create as  default_rh
		end

create
	default_create,
	make

feature {NONE} -- Initialization

	default_create
		do
			create facebook_api.make ("")
		end

	make (a_access_token: READABLE_STRING_32)
		do
			create facebook_api.make (a_access_token)
		end

feature -- Access

	last_status_code: INTEGER
			-- <Precuror>
		do
			if attached facebook_api.last_response as l_response then
				Result := l_response.status
			end
		end

feature -- Facebook API

	show_user (a_user_id: STRING; a_params: detachable FB_USER_PARAMETER): detachable FB_USER
		local
			err: DEVELOPER_EXCEPTION
		do
			if attached facebook_api.show_user (a_user_id, a_params) as s then
				if attached parsed_json (s) as j then
					if attached string_value_from_json (j, "error") as l_error then
						create err
						err.set_description (l_error)
						err.raise
					elseif attached {JSON_ARRAY} json_value (j, "errors") as l_array then
						create err
						if attached string_value_from_json (l_array.i_th (1), "message") as l_err_message then
							err.set_description (l_err_message)
						end
						err.raise
					else
						Result := fb_user (Void, j)
					end
				end
			end
		end

feature -- Implementation Factory

	fb_user (a_user: detachable like fb_user; a_json: JSON_VALUE): FB_USER
			-- Fill `a_user' from `a_json'
		require
			a_json_attached: a_json /= Void
		do
			if a_user /= Void then
				Result := a_user
			else
				create Result
			end
			Result.set_id (string_value_from_json (a_json, "id"))
			Result.set_name (string_value_from_json (a_json, "name"))
			Result.set_birthday (string_value_from_json (a_json, "birthday"))
			Result.set_email (string_value_from_json (a_json, "email"))
			Result.set_first_name (string_value_from_json (a_json, "first_name"))
			Result.set_gender (string_value_from_json (a_json, "gender"))
			Result.set_last_name (string_value_from_json (a_json, "last_name"))
			Result.set_link (string_value_from_json (a_json, "link"))
			Result.set_locale (string_value_from_json (a_json, "locale"))
			if attached {JSON_OBJECT} json_value (a_json, "location") as l_location then
					--Result.set_location (fb_page (Void, location))
			end
			Result.set_middle_name (string_value_from_json (a_json, "middle_name"))
			Result.set_time_zone (real_value_from_json (a_json, "time_zone"))

		end

feature --{NONE}

	stripslashes (s: STRING): STRING
		do
			Result := s.string
			Result.replace_substring_all ("\%"", "%"")
			Result.replace_substring_all ("\'", "'")
			Result.replace_substring_all ("\/", "/")
			Result.replace_substring_all ("\\", "\")
		end

feature -- Implementation

	print_last_json_data
			-- Print `last_json' data
		do
			internal_print_json_data (last_json, "  ")
		end

feature {NONE} -- Implementation

	facebook_api: FACEBOOK_API
			-- Facebook API object.

	last_json: detachable JSON_VALUE

	parsed_json (a_json_text: STRING): detachable JSON_VALUE
		local
			j: JSON_PARSER
		do
			create j.make_with_string (a_json_text)
			j.parse_content
			Result := j.parsed_json_value
			last_json := Result
		end

	json_value (a_json_data: detachable JSON_VALUE; a_id: STRING): detachable JSON_VALUE
		local
			l_id: JSON_STRING
			l_ids: LIST [STRING]
		do
			Result := a_json_data
			if Result /= Void then
				if a_id /= Void and then not a_id.is_empty then
					from
						l_ids := a_id.split ('.')
						l_ids.start
					until
						l_ids.after or Result = Void
					loop
						create l_id.make_from_string (l_ids.item)
						if attached {JSON_OBJECT} Result as v_data then
							if v_data.has_key (l_id) then
								Result := v_data.item (l_id)
							else
								Result := Void
							end
						else
							Result := Void
						end
						l_ids.forth
					end
				end
			end
		end

	internal_print_json_data (a_json_data: detachable JSON_VALUE; a_offset: STRING)
		local
			obj: HASH_TABLE [JSON_VALUE, JSON_STRING]
		do
			if attached {JSON_OBJECT} a_json_data as v_data then
				obj	:= v_data.map_representation
				from
					obj.start
				until
					obj.after
				loop
					print (a_offset)
					print (obj.key_for_iteration.item)
					if attached {JSON_STRING} obj.item_for_iteration as j_s then
						print (": " + j_s.item)
					elseif attached {JSON_NUMBER} obj.item_for_iteration as j_n then
						print (": " + j_n.item)
					elseif attached {JSON_BOOLEAN} obj.item_for_iteration as j_b then
						print (": " + j_b.item.out)
					elseif attached {JSON_NULL} obj.item_for_iteration as j_null then
						print (": NULL")
					elseif attached {JSON_ARRAY} obj.item_for_iteration as j_a then
						print (": {%N")
						internal_print_json_data (j_a, a_offset + "  ")
						print (a_offset + "}")
					elseif attached {JSON_OBJECT} obj.item_for_iteration as j_o then
						print (": {%N")
						internal_print_json_data (j_o, a_offset + "  ")
						print (a_offset + "}")
					end
					print ("%N")
					obj.forth
				end
			end
		end

	integer_value_from_json (a_json_data: detachable JSON_VALUE; a_id: STRING): INTEGER
		do
			if
				attached {JSON_NUMBER} json_value (a_json_data, a_id) as v and then
				v.numeric_type = v.integer_type
			then
				Result := v.item.to_integer
			end
		end

	integer_64_value_from_json (a_json_data: detachable JSON_VALUE; a_id: STRING): INTEGER_64
		do
			if
				attached {JSON_NUMBER} json_value (a_json_data, a_id) as v and then
				v.is_number
			then
				Result := v.integer_64_item
			end
		end

	real_value_from_json (a_json_data: detachable JSON_VALUE; a_id: STRING): REAL
		do
			if
				attached {JSON_NUMBER} json_value (a_json_data, a_id) as v and then
				v.numeric_type = v.real_type
			then
				Result := v.item.to_real
			end
		end

	boolean_value_from_json (a_json_data: detachable JSON_VALUE; a_id: STRING): BOOLEAN
		do
			if attached {JSON_BOOLEAN} json_value (a_json_data, a_id) as v then
				Result := v.item
			end
		end

	string_value_from_json (a_json_data: detachable JSON_VALUE; a_id: STRING): detachable STRING
		do
			if attached {JSON_STRING} json_value (a_json_data, a_id) as v then
				Result := v.item
			end
		end

	string32_value_from_json (a_json_data: detachable JSON_VALUE; a_id: STRING): detachable STRING_32
		do
			if attached {JSON_STRING} json_value (a_json_data, a_id) as v then
				Result := v.unescaped_string_32
			end
		end

	integer_tuple_value_from_json (a_json_data: detachable JSON_VALUE; a_id: STRING): detachable TUPLE [INTEGER, INTEGER]
		do
			if
				attached {JSON_ARRAY} json_value (a_json_data, a_id) as v and then
				v.count = 2 and then attached {JSON_NUMBER} v.i_th (1) as l_index_1 and then
				attached {JSON_NUMBER} v.i_th (2) as l_index_2 and then
				l_index_1.numeric_type = l_index_1.integer_type and then
				l_index_2.numeric_type = l_index_2.integer_type
			then
				Result := [l_index_1.item.to_integer, l_index_2.item.to_integer]
			end
		end

end
