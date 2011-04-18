export ZSH=$DOT_FILES/zsh/oh-my-zsh
export ZSH_THEME="risto"
plugins=(rails git ruby osx brew)

if [ -d "$ZSH" ]; then
  source $ZSH/oh-my-zsh.sh
else
  echo "Cloning Oh My Zsh..."
  /usr/bin/env git clone git://github.com/robbyrussell/oh-my-zsh.git "$ZSH"
  /usr/bin/env git clone git://github.com/nicoulaj/zsh-syntax-highlighting.git "$ZSH/plugins/zsh-syntax-highlighting"
  source $ZSH/oh-my-zsh.sh
fi
