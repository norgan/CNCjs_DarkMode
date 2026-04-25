# CNCjs Dark Mode Patch

A runtime dark mode patch for CNCjs 1.11.0.

This patch modifies:

/usr/lib/node_modules/cncjs/dist/cncjs/app/index.hbs

It injects a dark theme layer after CNCjs loads, then applies runtime fixes for React-rendered inline styles, xterm console rendering, settings pages, and visualizer workflow controls.

Tested on CNCjs 1.11.0 running on Debian 13/Raspberry Pi.
<img width="1881" height="997" alt="image" src="https://github.com/user-attachments/assets/c5006252-b83d-4084-876c-edda3d2ec94a" />
