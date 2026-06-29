# Search - REF: https://searchfox.org/firefox-main/source/modules/libpref/init/StaticPrefList.yaml
{
  "browser.startup.homepage" = "https://schwem.io";
  "browser.theme.content-theme" = 2;
  "browser.theme.toolbar-theme" = 2;

  "general.smoothScroll" = true;
  "general.useragent.override" =
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.10 Safari/605.1.1";

  # 0 - Dark.   1 - Light.    2 - system color scheme unless overridden by browser theme.
  "layout.css.prefers-color-scheme.content-override" = 2;

  # resistFingerprinting overrides fingerprintingProtection, so these must be disabled
  "privacy.resistFingerprinting" = false;
  "privacy.resistFingerprinting.pbmode" = false;

  # At least one of these two must be enabled
  "privacy.fingerprintingProtection" = true;
  "privacy.fingerprintingProtection.pbmode" = true;

  # "privacy.fingerprintingProtection.overrides" = "+AllTargets,-CSSPrefersColorScheme";
  "privacy.fingerprintingProtection.overrides" =
    "-CSSPrefersColorScheme,+TouchEvents,+PointerEvents,+KeyboardEvents,+ScreenOrientation,+SpeechSynthesis,+CSSPrefersReducedMotion,+CSSPrefersContrast,+CanvasRandomization,+CanvasImageExtractionPrompt,+CanvasExtractionFromThirdPartiesIsBlocked,+CanvasExtractionBeforeUserInputIsBlocked,+NavigatorAppName,+NavigatorAppVersion,+NavigatorBuildID,+NavigatorHWConcurrency,+NavigatorOscpu,+NavigatorPlatform,+NavigatorUserAgent,+StreamTrackLabel,+StreamVideoFacingMode";

  # boosts are worthless... no hex code entry for colors and foreground color is linked in a way
  # that is not intuitive
  "zen.boosts.enabled" = false;

  "zen.tabs.ctrl-tab.ignore-essential-tabs" = true;
  "zen.tabs.ctrl-tab.ignore-pending-tabs" = true;
  "zen.tabs.show-newtab-vertical" = false;

  "zen.theme.use-system-colors" = true;
  "zen.theme.hide-unified-extensions-button" = false;

  "zen.watermark.enabled" = false;
  "zen.welcome-screen.seen" = true;
}
