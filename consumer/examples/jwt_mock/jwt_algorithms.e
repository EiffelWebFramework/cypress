note
	description: "JSON Web Algorithms (JWA)"
	date: "$Date: 2018-11-08 11:44:59 -0300 (ju. 08 de nov. de 2018) $"
	revision: "$Revision: 102415 $"
	EIS: "name= JSON Web Algorithms", "src=https://tools.ietf.org/html/rfc7518", "protocol=uri"


class
	JWT_ALGORITHMS

inherit
	ANY
		redefine
			default_create
		end

create
	default_create

feature {NONE} -- Initialization

	default_create
		do
			create items.make_caseless (2)
		end

feature -- Access


feature -- Access

	default_algorithm: JWT_ALG
		do
			create {JWT_ALG_RS256} Result
		end

	algorithm alias "[]" (a_name: READABLE_STRING_GENERAL): detachable JWT_ALG
		do
		end

feature -- Element change

	register_algorithm (alg: attached like algorithm)
		do
		end

	unregister_algorithm (a_alg_name: READABLE_STRING_GENERAL)
		do
		end

	set_default_algorithm (a_alg_name: detachable READABLE_STRING_GENERAL)
		do
		end

feature -- Status report	

	is_supported_algorithm (a_name: READABLE_STRING_GENERAL): BOOLEAN
		do
		end

feature {NONE} -- Implementation

	items: STRING_TABLE [attached like algorithm]

	internal_default_alg_name: detachable READABLE_STRING_GENERAL

invariant

end
