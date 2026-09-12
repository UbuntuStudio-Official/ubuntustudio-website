# Post Installation
- [back](../)
all tips here are for ubuntu 26.04
## grab a browser if firefox still not available
`sudo apt install falkon`

## avoiding yoshimi crash in wayland
```
# thie method is used in ardour-1:9.0.0+ds-1ubuntu2 and later.
# therefore no action needed in new installations with online updates.
#
# older installations may still encounter this issue. 
# (such as offline installations)
```
add `FLTK_BACKEND=x11` env for any DAW

> reference:
> https://github.com/Yoshimi/yoshimi/issues/243

## sudo hide password
in case you miss the no-feedback experience.

`echo "Defaults !pwfeedback" | sudo tee /etc/sudoers.d/00-passwordfeedback`

## RDP support
- install the package via `sudo apt install krdp`
- then the "remote desktop" entry will appear in system settings.

## X11 session
This setup is not recommended and is going to be deprecated,
but may required for some third party remote desktop softwares to achieve unattended access.

`sudo apt install plasma-session-x11`
