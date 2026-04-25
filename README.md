# CNCjs Dark Mode Patch

A runtime dark mode patch for CNCjs 1.11.0.

This patch modifies:

/usr/lib/node_modules/cncjs/dist/cncjs/app/index.hbs

It injects a dark theme layer after CNCjs loads, then applies runtime fixes for React-rendered inline styles, xterm console rendering, settings pages, and visualizer workflow controls.

Tested on CNCjs 1.11.0 running on Debian 13/Raspberry Pi. Workspace and settings.

Not Tested: User account pages, help, any other ancillary pages. 
Main workspace:
<img width="1881" height="997" alt="image" src="https://github.com/user-attachments/assets/c5006252-b83d-4084-876c-edda3d2ec94a" />
Console:
<img width="440" height="427" alt="image" src="https://github.com/user-attachments/assets/cec33a29-3e0c-419c-bb11-624e4eabc53b" />
Settings:
<img width="1903" height="852" alt="image" src="https://github.com/user-attachments/assets/17242a2f-fd0f-4c4c-ac7d-98c1fe299066" />
