#!/usr/bin/sh

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# Excluding this for now, not really a
# fan of installing Java in my machine
# Android SDK
# export JAVA_HOME=$(/usr/libexec/java_home)
# export ANDROID_SDK="$(brew --prefix android-sdk)"
# export JAVA_PATH="${PATH}/Applications/Android\ Studio.app/sdk/platform-tools:/Applications/Android\ Studio.app/sdk/tools"
# export JAVA_PATH="${JAVA_HOME}/bin:$JAVA_PATH"
# export JAVA_PATH="/usr/local/bin:$JAVA_PATH"

# Make /Applications the default location of apps
export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# Thanks for the awesome idea batasrki
function gemdir {
  if [[ -z "$1" ]] ; then
    echo "gemdir expects a parameter, which should be a valid RVM Ruby selector"
  else
    rvm "$1"
    cd $(rvm gemdir)
    pwd
  fi
}

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
