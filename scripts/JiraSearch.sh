#!/bin/bash

if pgrep -x walker >/dev/null; then
    pkill walker
fi

echo "" | walker --dmenu -p 'Enter Jira # (AC-XXXX, AMPS-XXXX):' | xargs -I{} xdg-open "https://crankuptheamps.atlassian.net/browse/{}"
