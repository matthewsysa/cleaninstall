#!/bin/sh

# copy .zshrc to ~
cp $HOME/Library/Mobile\ Documents/com\~apple\~CloudDocs/tech/\~reinstall/.zshrc $HOME

# disable hiding the library folder
chflags nohidden ~/Library

# disable shadow in screenshots
defaults write com.apple.screencapture "disable-shadow" -bool "true"

# disable dock by setting the autohide delay to 1000 seconds (ie. dock appears when mouse does not move near dock position for 1000 seconds)
defaults write com.apple.dock "autohide-delay" -float "1000" && killall Dock

# disable emoji suggestions (https://apple.stackexchange.com/questions/465132/how-do-i-turn-off-macos-sonomas-emoji-guessing)
sudo defaults write /Library/Preferences/FeatureFlags/Domain/UIKit.plist emoji_enhancements -dict-add Enabled -bool NO

# reenable emoji suggestions
# sudo defaults write /Library/Preferences/FeatureFlags/Domain/UIKit.plist emoji_enhancements -dict-add Enabled -bool YES

# create .config directory
mkdir $HOME/.config

# create mpv config folder and copy config files
mkdir $HOME/.config/mpv
cp $HOME/Library/Mobile\ Documents/com\~apple\~CloudDocs/tech/\~reinstall/mpv/mpv.conf $HOME/.config/mpv

# create kitty config folder and copy config files
mkdir $HOME/.config/kitty
cp $HOME/Library/Mobile\ Documents/com\~apple\~CloudDocs/tech/\~reinstall/kitty/kitty.app.png $HOME/.config/kitty/
cp $HOME/Library/Mobile\ Documents/com\~apple\~CloudDocs/tech/\~reinstall/kitty/kitty.conf $HOME/.config/kitty/

# install kitty
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

# install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" && brew analytics off

# install via homebrew the latest version instead of stable
brew install --HEAD ffmpeg
brew install --HEAD yt-dlp
brew install --HEAD whisper-cpp

# clear homebrew cache (~/Library/Caches/Homebrew)
brew cleanup --prune=all

# smaller menubar icon size https://forums.macrumors.com/threads/menu-bar-spacing.2242794/page-2?post=32921536#post-32921536
# defaults -currentHost write -globalDomain NSStatusItemSpacing -int 6
# defaults -currentHost write -globalDomain NSStatusItemSelectionPadding -int 6

# revert to default menubar icon size
# defaults -currentHost write -globalDomain NSStatusItemSpacing
# defaults -currentHost write -globalDomain NSStatusItemSelectionPadding