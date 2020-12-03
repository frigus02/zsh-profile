# Watch notes

I like to keep my notes in text files in a folder on my laptop. This describes a way on macOS to automatically commit all changes to files to a local git repository.

## Assumptions

- `HOME` is: `/Users/jkuehle`
- Notes are in: `$HOME/Downloads/notes`

## Steps

1. Initialize repository

   ```sh
   cd "$HOME/Downloads/notes"
   git init
   ```

1. Create launch agent configuration. Create a file with the following content and save it in `$HOME/Library/LaunchAgents/me.kuehle.watchnotes.plist`:

   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
   <plist version="1.0">
   <dict>
   	<key>Label</key>
   	<string>me.kuehle.watchnotes</string>
   	<key>ProgramArguments</key>
   	<array>
   		<string>/bin/sh</string>
   		<string>-ec</string>
   		<string>if [ -n "$(/usr/bin/git status --porcelain --ignore-submodules -unormal .)" ]; then /usr/bin/git add .; /usr/bin/git commit --no-gpg-sign -m "$(/usr/bin/git status --porcelain)"; fi</string>
   	</array>
   	<key>WatchPaths</key>
   	<array>
   		<string>/Users/jkuehle/Downloads/notes</string>
   	</array>
   	<key>WorkingDirectory</key>
   	<string>/Users/jkuehle/Downloads/notes</string>
   	<key>ProcessType</key>
   	<string>Background</string>
   </dict>
   </plist>
   ```

1. Start the launch agent

   ```sh
   launchctl load "$HOME/Library/LaunchAgents/me.kuehle.watchnotes.plist"
   ```

1. This will fail until `/bin/sh` has has permissions to access the folder. You can give permissions by going to _System Preferences -> Security and Privacy -> Full Disk Access_ and adding `/bin/sh` to the list.
