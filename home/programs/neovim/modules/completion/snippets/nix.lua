return {
	s({
		trig = "fetchFromGitHub",
		namr = "fetchFromGitHub",
		dscr = "Fetch src from GitHub",
	}, {
		text({ "fetchFromGitHub {", '  owner = "' }),
		insert(1, "owner"),
		text({ '";', '  repo = "' }),
		insert(2, "repo"),
		text({ '";', '  rev = "' }),
		insert(3, "revision"),
		text({ '";', '  hash = "' }),
		insert(4, "${lib.fakeHash}"),
		text({ '";', "};" }),
		insert(0),
	}),
}
