#!/bin/bash

if pgrep -x walker >/dev/null; then
    pkill walker
fi

echo "" | omarchy-menu-input 'Enter Jira #:' | xargs -I{} xdg-open "https://crankuptheamps.atlassian.net/browse/{}"
