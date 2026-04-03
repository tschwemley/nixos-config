local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
	s("parse-opts", {
		t({
			"while [[ $# -gt 0 ]]; do",
			'    case "$1" in',
			'        -v|--verbose) verbose="$2"; shift 2 ;;',
			'        -h|--help)    echo "Usage: ..."; exit 0 ;;',
			'        *)            args+=("$1"); shift ;;',
			"    esac",
			"done",
		}),
	}),
}
