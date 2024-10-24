const battery = await Service.import("battery");

const batteryProgress = () => {
  // only return the battery widget if the system has a battery
  if (!battery.available) {
    return;
  }

  //return Widget.CircularProgress({
  //  child: Widget.Icon({
  //    icon: battery.bind("icon_name"),
  //  }),
  //  visible: battery.bind("available"),
  //  value: battery.bind("percent").as((p) => (p > 0 ? p / 100 : 0)),
  //  class_name: battery.bind("charging").as((ch) => (ch ? "charging" : "")),
  //});
  //

  return Widget.Icon({
    icon: battery.bind("icon_name"),
  });
};

export default batteryProgress;
