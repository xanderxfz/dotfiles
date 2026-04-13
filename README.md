# dotfiles
My personal dotfiles.

## Setup

```
git clone https://github.com/xanderxfz/dotfiles.git && cd dotfiles && ./apply.sh
```

## Llama Installation

This section details how to set up the Llama service.

1. Install the system dependencies using the provided script:
   `sudo ./llama/install.sh`

2. Download the latest binaries:
   `~/bin/update_llama.sh`

3. Place your GGUF model in `/opt/llama.cpp/models/`.

4. Enable and start the service:
   `sudo systemctl enable --now llama-server`

## Debugging
To view the live logs of the llama-server service, run:
`sudo journalctl -u llama-server -f`

## TODO
- Try [dotbot](https://github.com/anishathalye/dotbot)