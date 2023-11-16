{ ... }:
{
    imports = [./.];
    
    services.k3s.role = "agent";
}
