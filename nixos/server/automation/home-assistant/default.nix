{
  services.home-assistant = {
    enable = true;

    config = {
      # Includes dependencies for a basic setup
      # https://www.home-assistant.io/integrations/default_config/
      default_config = {};
    };

    # extraComponents = [
    #   # Components required to complete the onboarding
    #   "analytics"
    #   "google_translate"
    #   "met"
    #   "radio_browser"
    #   "shopping_list"
    #   # Recommended for fast zlib compression
    #   # https://www.home-assistant.io/integrations/isal
    #   "isal"
    # ];
  };
}
