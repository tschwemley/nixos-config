{ self, ... }: {
  imports = [ self.inputs.hermes-agent.nixosModules.default ];
}
