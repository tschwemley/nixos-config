local ls = require("luasnip")
local s = ls.snippet
local fmt = require("luasnip.extras.fmt").fmt

return {
  s(
    "args",
    fmt(
      [[
      while [[ "$#" -gt 0 ]]; do
          case $1 in
              -h|--help) 
                  usage
                  exit 0
                  ;;
              -f|--file)
                  {}="$2"
                  shift 
                  ;;
              *)
                  echo "Unknown option: $1"
                  exit 1
                  ;;
          esac
          shift
      done
      ]],
      {
        i(1, "filename"),
      }
    )
  ),
  s(
    "usage",
    fmt(
      [[
      usage() {{
          echo "Usage: $0 [options]"
          echo "Options:"
          echo "  -h, --help      Show this help message"
          echo "  -f, --file FILE Specify input file"
          {}
      }}
      ]],
      {
        i(1, ""),
      }
    )
  ),
}
