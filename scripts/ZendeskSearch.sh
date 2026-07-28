#!/bin/bash

if pgrep -x walker >/dev/null; then
    pkill walker
fi

echo "" | walker --dmenu -p 'Enter Zendesk Ticket # (zXXXXX):'| xargs -I{} xdg-open "https://crankuptheamps.zendesk.com/agent/tickets/{}"
