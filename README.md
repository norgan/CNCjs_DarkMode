# CNCjs Dark Mode Patch

A runtime dark mode patch for CNCjs 1.11.0.

This patch modifies:

/usr/lib/node_modules/cncjs/dist/cncjs/app/index.hbs

It injects a dark theme layer after CNCjs loads, then applies runtime fixes for React-rendered inline styles, xterm console rendering, settings pages, and visualizer workflow controls.

Tested on CNCjs 1.11.0 running on Debian 13/Raspberry Pi.
