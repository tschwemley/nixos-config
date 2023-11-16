{ ... }:
{
    imports = [./.];
    
    services.k3s.role = "server"; 
}
