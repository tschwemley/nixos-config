# REF: https://firefox-admin-docs.mozilla.org/reference/policies/
{
  AutofillAddressEnabled = false;
  AutofillCreditCardEnabled = false;
  DisableAppUpdate = true;
  DisableFeedbackCommands = true;
  DisableFirefoxStudies = true;
  DisableFormHistory = true;
  DisablePocket = true;
  DisableRemoteImprovements = true;
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

  PasswordManagerEnabled = false;

  Preferences = import ./preferences.nix;

  UserMessaging = {
    ExtensionRecommendations = false;
    FeatureRecommendations = false;
    FirefoxLabs = false;
    Locked = false;
    MoreFromMozilla = false;
    SkipOnboarding = true;
    UrlbarInterventions = false;
  };
}
