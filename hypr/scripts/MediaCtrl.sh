#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Playerctl

music_icon="$HOME/.config/swaync/icons/music.png"

# Play the next track
play_next() {
    skipping=true
    playerctl next
    show_music_notification
}

# Play the previous track
play_previous() {
    rewinding=true
    playerctl previous
    show_music_notification
}

# Toggle play/pause
toggle_play_pause() {
    playerctl play-pause
    show_music_notification
}

# Stop playback
stop_playback() {
    playerctl stop
    notify-send -e -u low -i $music_icon " Playback:" " Stopped"
}

# Display notification with song information
show_music_notification() {
    if [ "$skipping" ] || [ "$rewinding" ]; then
        status="Paused"
        if [ "$skipping" ]; then
            prev_title=$(playerctl metadata title)
            while [ "$(playerctl metadata title)" = "$prev_title" ]; do
                sleep 0.1
            done
        fi
    else
        status=$(playerctl status)
    fi

    case "$status" in
    "Playing")
        notify-send -e -u low -i $music_icon " Playback:" " Paused"
        ;;
    "Paused")
        song_title=$(playerctl metadata title)
        song_artist=$(playerctl metadata artist)
        notify-send -e -u low -i $music_icon " Now Playing:" " $song_title byn $song_artist"
        ;;
    "Stopped" | "")
        notify-send -e -u low -i $music_icon " Playback:" " Stopped"
        ;;
    esac
}

# Get media control action from command line argument
case "$1" in
"--nxt")
    play_next
    ;;
"--prv")
    play_previous
    ;;
"--pause")
    toggle_play_pause
    ;;
"--stop")
    stop_playback
    ;;
*)
    echo "Usage: $0 [--nxt|--prv|--pause|--stop]"
    exit 1
    ;;
esac
