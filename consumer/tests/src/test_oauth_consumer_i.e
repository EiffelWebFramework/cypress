note
	description: "Summary description for {TEST_OAUTH_CONSUMER_I}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_OAUTH_CONSUMER_I

inherit
	EQA_TEST_SET
		redefine
			on_prepare
		end

	SHARED_EXECUTION_ENVIRONMENT
		undefine
			default_create
		end

feature {NONE} -- Events

	on_prepare
			-- Called after all initializations in `default_create'.
		do
			prepare_data
		end

feature -- Helper

	prepare_data
		local
			d: DIRECTORY
			p: PATH
		do
			p := execution_environment.current_working_path
			
			create d.make ("data")
			if not d.exists then
				d.recursive_create_dir
			end
			execution_environment.change_working_directory (d.name)
		end

end
