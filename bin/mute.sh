#/bin/sh
CURRENT_OUTPUT=$(SwitchAudioSource -c -t output)

/usr/local/bin/SwitchAudioSource -t output -s "Built-in Output"
osascript -e "set Volume output volume 0"
/usr/local/bin/SwitchAudioSource -t output -s "$CURRENT_OUTPUT"
