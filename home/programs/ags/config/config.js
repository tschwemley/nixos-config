import Bar from './statusbar/statusbar.js';

App.config({
  style: "./style.css",
  windows: [
    Bar(),

    // you can call it, for each monitor
    // Bar(0),
    // Bar(1)
  ],
})

export { }
