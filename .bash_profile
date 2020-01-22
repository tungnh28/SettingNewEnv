alias gvimtab='mvim --remote-tab-silent'

if [ -d ~/.mozbuild/version-control-tools/git-cinnabar ]; then
    PATH=$PATH:~/.mozbuild/version-control-tools/git-cinnabar
fi

if [ -d ~/.mozbuild/git-cinnabar ]; then
    PATH=$PATH:~/.mozbuild/git-cinnabar
fi

#https://mozilla-version-control-tools.readthedocs.io/en/latest/
if [ -d ~/.mozbuild/version-control-tools/git/commands ]; then
    PATH=$PATH:~/.mozbuild/version-control-tools/git/commands
fi

#if [ -d ~/.mozbuild/version-control-tools/git-bz-moz ]; then
#    PATH=$PATH:~/.mozbuild/version-control-tools/git-bz-moz
#fi

if [ -d ~/.mozbuild/android-sdk-macosx/platform-tools/ ]; then
    PATH=$PATH:/Users/tnguyen/.mozbuild/android-sdk-macosx/platform-tools
fi

if [ -d ~/bin/ ]; then
    PATH=$PATH:~/bin
fi

if [ -d ~/.mozbuild/version-control-tools/arcanist/bin ]; then
    PATH=$PATH:~/.mozbuild/version-control-tools/arcanist/bin
fi

if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

if [ -d ~/.cargo/bin ]; then
    PATH=$PATH:~/.cargo/bin
fi

#https://github.com/mozilla/moz-git-tools 
if [ -d ~/.mozbuild/moz-git-tools ]; then
    PATH=$PATH:~/.mozbuild/moz-git-tools
fi

if [ -d ~/.mozbuild/moz-git-tools/git-bz-moz ]; then
    PATH=$PATH:~/.mozbuild/moz-git-tools/git-bz-moz
fi

if [ -d ~/.mozbuild/clang/bin ]; then
    PATH=$PATH:~/.mozbuild/clang/bin
fi

function gitfixup {
  if [ $# -ge 1 ]
  then
    if [[ "$1" == --abort ]]
    then
      git rebase --abort; git reset HEAD~1;
    else
      TARGET=$(git rev-parse "$1");
      if [ $# -eq 1 ]
      then
        git add .;
      fi

      FIXUP="--fixup=$TARGET ${@:2}";
      EDITOR=true;
      git commit --allow-empty $FIXUP;
      git rebase -i --autostash --autosquash $TARGET^;
      EDITOR=vim;
    fi
  else
    echo "Usage: gitfixup <commit-ref> <diff_file(optional)> or gitfixup --abort"
  fi
}

function machclangformat {
  git commit --allow-empty -a -m "machclangformatTemp";
  ./mach clang-format -c HEAD;
  git reset HEAD~1;
}

function sccachebuild {
  status=$(sccache --dist-status)
  if [ -f ./mozconfig ]; then
    echo "Found mozconfig file"
    if grep -q "use_sccache_build:yes" ./mozconfig; then
      if [[ $status == *"num_cpus"* ]]; then
        echo "Building using sccache"
        number_available=`echo $status | sed 's/.*num_cpus":\(.*\),.*/\1/'`
        echo "Build with" $((number_available/2)) "cores"
        ./mach build -j$((number_available/2))
      else
        echo "Seems we need to auth again. Please run sccache --dist-auth &&
          sccache --stop-server"
      fi
    else
      echo "No sccache in mozconfig file, run as default ./mach build -j8"
      ./mach build -j8
    fi
  else
    echo "No mozconfig file, run as default ./mach build -j8"
    ./mach build -j8
  fi
}

export PS1='\[\e[1;32m\][\u@\h \W]\$\[\e[0m\] '
export EDITOR=vim
export PATH="/usr/local/opt/python/libexec/bin:$PATH"

alias sccachelog='SCCACHE_NO_DAEMON=1 RUST_LOG=sccache /Users/tnguyen/.cargo/bin/sccache --start-server'
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES;
killall Finder /System/Library/CoreServices/Finder.app'
alias hiddenFiles='defaults write com.apple.finder AppleShowAllFiles NO;
killall Finder /System/Library/CoreServices/Finder.app'

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
