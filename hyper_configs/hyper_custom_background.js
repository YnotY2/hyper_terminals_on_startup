"use strict";

const backgrounds = [
"/home/custom_configs/hyper_terminal/backround_images/lofi_market_night.jpg",
"/home/custom_configs/hyper_terminal/backround_images/lofi_pink_night_shop.png",
"/home/custom_configs/hyper_terminal/backround_images/lofi_market_city.jpeg",
"/home/custom_configs/hyper_terminal/backround_images/bar_fishtank.jpg",
"/home/custom_configs/hyper_terminal/backround_images/night_hotel_clean.jpeg",
"/home/custom_configs/hyper_terminal/backround_images/gray_building_pole_clean.jpeg",
];

module.exports = {
  config: {
    // font config
    fontSize: 13,
    fontFamily: 'Menlo, "DejaVu Sans Mono", Consolas, "Lucida Console", monospace',
    // cursor config
    cursorColor: '#EBCB8B',
    cursorShape: 'BLOCK',
    cursorBlink: true,
    // color config
    foregroundColor: '#fff',
    backgroundColor: '#000',
    borderColor: '#333',
    // css config
    css: `
      .header_header {
        content: ''; /* Hide the username */
      }
    `,
    termCSS: '',
    // window and color config
    showHamburgerMenu: false,
    showWindowControls: false, // Hide the user name from the console toolbar
    padding: '12px 14px',
    colors: {
      // ...
    },
    // shell config
    shell: '/bin/bash', // Updated shell configuration
    shellArgs: ['--login'],
    env: {},
    // behaviour config
    bell: false,
    copyOnSelect: false,

    // Set the background image using the hyper-background plugin
    backgroundImage: backgrounds[Math.floor(Math.random() * backgrounds.length)],

  },
  plugins: [
    "hyper-background",
    "hyper-startup" // Add hyper-startup plugin
  ]
};
