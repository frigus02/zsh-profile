# Watch notes

I like to keep my notes in text files in a folder on my laptop. This describes a way on macOS to automatically commit all changes to files to a local git repository.

## Assumptions

- `HOME` is: `/Users/jkuehle`
- Notes are in: `$HOME/Downloads/notes`

## Steps

1. Install `vcsh` and initialize repository

   ```sh
   brew install vcsh
   vcsh init notes
   vcsh notes add "$HOME/Downloads/notes"
   vcsh notes commit -m init
   ```

2. Create launch agent configuration. Create a file with the following content and save it in `$HOME/Library/LaunchAgents/me.kuehle.watchnotes.plist`:

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
           <string>if [ -n "$(/usr/local/bin/vcsh notes status --porcelain --ignore-submodules -unormal .)" ]; then /usr/local/bin/vcsh notes add .; /usr/local/bin/vcsh notes commit --no-gpg-sign -m change; fi</string>
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

3. Start the launch agent

   ```sh
   launchctl load "$HOME/Library/LaunchAgents/me.kuehle.watchnotes.plist"
   ```
