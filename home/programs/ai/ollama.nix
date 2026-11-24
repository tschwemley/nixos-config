{
  service.ollama = {
    enable = true;

    # NOTE: Be aware that these are only seen by the ollama server (systemd service), not normal
    # invocations like ollama run. Since ollama run is mostly a shell around the ollama server,
    # this is usually sufficient.
    environmentVariables = {
      OLLAMA_FLASH_ATTENTION = "1";
      OLLAMA_KV_CACHE_TYPE = "q8_0";
    };
  };
}
