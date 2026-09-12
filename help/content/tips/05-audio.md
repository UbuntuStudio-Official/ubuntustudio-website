# Audio tips
- [back to index](../)

## the migration from jackd to pipewire
from 23.04, Ubuntu Studio has migrated from using `jackd` to `PipeWire` for audio management. 
And the jackd method was deprecated starting from 24.10.
- the PipeWire provides jack-compatible audio management, allowing applications that previously relied on `jackd` to work seamlessly with PipeWire.
- In any application, use jack for audio backend will connect to PipeWire seamlessly.
## the pipewire widget
from 26.04, Ubuntu Studio includes a widget in the system tray for PipeWire, 
making it easier to change sample rate and buffer size.

- also there is a button for a quick switch to a preset profile, default to 128/48000, 
which aims for low latency and high performance, 
the button is displayed with the text `<buffer>/<sample_rate>`, 
thus the default is shown as `128/48000`.

## the wiring panel
Patchance is a built-in tool in Ubuntu Studio for managing audio connections, 
it can be opened from the taskbar (default the second icon, `<Meta>+2` for keyboard shortcut).