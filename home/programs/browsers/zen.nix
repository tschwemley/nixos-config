{ self, pkgs, ... }:
{
  # imports = [ self.inputs.zen-browser.homeModules.twilight ];
  imports = [ self.inputs.zen-browser.homeModules.default ];

  programs.zen-browser = {
    enable = true;

    nativeMessagingHosts = [ pkgs.firefoxpwa ];

    # REF: https://mozilla.github.io/policy-templates/
    policies = {
      AutofillAddressEnabled = true;
      AutofillCreditCardEnabled = false;
      DisableAppUpdate = true;
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      SearchSuggestEnabled = false;
      WindowsSSO = false;

      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };

      # fuck firefox's bullshit
      FirefoxHome = {
        Highlights = false;
        Locked = false;
        Pocket = false;
        Search = false;
        Snippets = false;
        SponsoredPocket = false;
        SponsoredStories = false;
        SponsoredTopSites = false;
        Stories = false;
        TopSites = false;
      };

      FirefoxSuggest = {
        ImproveSuggest = false;
        Locked = false;
        SponsoredSuggestions = false;
        WebSuggestions = false;
      };

      Preferences = {
        # "apz.autoscroll.enabled" = true;
        "general.authscroll" = true;
        "general.smoothScroll" = true;
      };

      UserMessaging = {
        ExtensionRecommendations = false;
        FeatureRecommendations = false;
        FirefoxLabs = false;
        Locked = false;
        MoreFromMozilla = false;
        SkipOnboarding = true;
        UrlbarInterventions = false;
      };
    };
  };
}
