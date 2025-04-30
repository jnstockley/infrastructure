{
  config,
  pkgs,
  ...
}:
{
system.activationScripts.applications.text = ''
# Clear all Finder favorites
/usr/local/bin/mysides remove all

# Add Finder favorites
/usr/local/bin/mysides add Applications file:///Applications/
/usr/local/bin/mysides add Downloads file://"$HOME"/Downloads/
/usr/local/bin/mysides add Documents file://"$HOME"/Documents
/usr/local/bin/mysides add Home file://"$HOME"

if [ ! -d "$HOME"/Nextcloud ]; then
    mkdir "$HOME"/Nextcloud
fi

/usr/local/bin/mysides add Nextcloud file://"$HOME"/Nextcloud

killall Finder

sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate AutomaticallyInstallMacOSUpdates -bool TRUE
'';
}