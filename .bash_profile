
# Export PATH after RVM installation
PATH="/usr/local/bin:/Users/Pongstr/.rvm/gems/ruby-2.0.0-p247@global/bin:$PATH"

# Make /Applications the default location of apps
HOMEBREW_CASK_OPTS="--appdir=/Applications"

#  Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"