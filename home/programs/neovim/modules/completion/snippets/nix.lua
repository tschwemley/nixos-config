local helpers = require(".helpers")
local c = helpers.c
local i = helpers.i
local s = helpers.s
local t = helpers.t

-- Snippet Definitions
-- ===================

local fake_hash =
    s({ trig = "fakeHash", namr = "Fake Hash (Raw)" }, t("sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="))

local fetch_github = s({
   trig = "fetchFromGitHub",
   namr = "fetchFromGitHub",
   dscr = "Fetch src from GitHub",
}, {
   t({ "fetchFromGitHub {", '  owner = "' }),
   i(1, "owner"),
   t({ '";', '  repo = "' }),
   i(2, "repo"),
   t({ '";', '  rev = "' }),
   i(3, "revision"),
   t({ '";', '  hash = "' }),
   i(4, "${lib.fakeHash}"),
   t({ '";', "};" }),
   i(0),
})

local hm_module = s({
   trig = "hmmodule",
   namr = "Home Manager Module (Dynamic Args)",
   dscr = "Basic structure for a Home Manager module with selectable args",
}, {
   -- Choice node for the arguments
   c(1, {
      -- Option 1: Common Home Manager args
      t("{ config, lib, pkgs, ... }:"),

      -- Option 2: Program-specific (often only needs pkgs)
      t("{ pkgs, ... }:"),

      -- Option 3: Service-specific (often needs config, lib)
      t("{ config, lib, ... }:"),

      -- Option 4: Minimal (only config, for simple overrides)
      t("{ config, ... }:"),

      -- Option 5: All (less common for specific modules but an option)
      t("{ config, lib, pkgs, options, ... }:"),

      -- Option 6: Empty (if you just need a simple attribute set)
      t("{ ... }:"),
   }),
   t({ "", "{" }),                                   -- Blank line and opening brace after chosen args
   i(2, "  # Your Home Manager configuration here"), -- Tabstop for the main config body
   t({ "", "}" }),                                   -- Closing brace
   i(0),                                             -- Final tabstop
})

local nixos_module = s({
   trig = "nixosmodule",
   namr = "NixOS Module (Dynamic Args)",
   dscr = "Basic structure for a NixOS module with selectable args",
}, {
   -- Choice node for the arguments
   c(1, {
      -- Option 1: Full common args
      t("{ config, lib, pkgs, options, ... }:"),

      -- Option 2: Common for simpler modules (no explicit options block needed often)
      t("{ config, lib, pkgs, ... }:"),

      -- Option 3: Service modules (often needs config, lib, pkgs)
      t("{ config, lib, pkgs, ... }:"),

      -- Option 4: Hardware modules (often needs config, lib)
      t("{ config, lib, ... }:"),

      -- Option 5: Minimal (e.g., just importing other modules)
      t("{ ... }:"),
   }),
   t({ "", "{" }), -- Blank line and opening brace after chosen args

   -- Single tabstop for the body content, including options/config if desired
   i(
      2,
      [[  # Common Structure Examples:
  # options = {
  #   myOption = lib.mkOption {
  #     type = lib.types.bool;
  #     default = false;
  #     description = "Enable my feature.";
  #   };
  # };

  # config = lib.mkIf config.moduleName.myOption {
  #   # Your configuration here
  # };]]
   ),              -- Tabstop for the main module body with examples

   t({ "", "}" }), -- Closing brace
   i(0),           -- Final tabstop
})

return {
   fake_hash
   fetch_github,
   hm_module,
   nixos_module,
}
