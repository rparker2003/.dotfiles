#!/bin/bash

if pgrep -x walker >/dev/null; then
    pkill walker
fi

echo "" | omarchy-menu-input 'Enter Zendesk Ticket # (zXXXXX):'| xargs -I{} xdg-open "https://crankuptheamps.zendesk.com/agent/tickets/{}"
