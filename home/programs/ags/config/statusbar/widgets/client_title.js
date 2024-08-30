const ClientTitle = () => Widget.Label({
  class_name: "client-title",
  label: hyprland.active.client.bind("title"),
})

export default ClientTitle
