# [jack](https://github.com/jackfletch)'s dotfiles

![terminal-screenshot]

## Install

### Using Git

Clone the respository into `~/dotfiles`.
You _should_ technically be able to clone to wherever you want, since I tried to avoid relative paths in the setup process.
However, I use `~/dotfiles` and everything herein has been tested with respect to that.

```sh
git clone https://github.com/jackfletch/dotfiles.git
cd dotfiles
# run setup script that has yet to be written
```

The above install process will:

- Download the dotfiles to your computer (i.e., `~/dotfiles`)

**TODO:**

- Create some additional directories (`$HOME/.vim/{backups,swaps,undo}/`)
- Symlink files to `$HOME`
- Install various necessary applications, command-line tools, and programming languages (Go)
- Install docker, kubernetes, containerd from source
- Set custom preferences
- Install vim plugins

### Git-free install

**TODO**

## Customize

### Local Settings

There are settings that shouldn't be committed to a public git repo, because they either:

1. should be different across your machines, or
1. are personal or private (e.g., `git` user name and email)

These `dotfiles` can be easily extended to suit these additional _local_ settings.
The following files, if they exist, will be sourced after their associated non-local counterparts, allowing their contents to add to or overwrite the default configuration:

#### `~/.local`

Add custom aliases, exports, etc.:

```sh
# Set local aliases
alias starwars="telnet towel.blinkenlights.nl"

# Set PATH additions
PATH="$PATH:$HOME/dotfiles/bin"
export PATH
```

#### `~/.gitconfig.local`

**Note:** Use `~/.gitconfig.local` to store sensitive information such as the `git` user credentials, e.g.:

```ini
[user]
    name = Jack Fletcher
    email = jack@example.com
    signingkey = XXXXXXXX

[commit]
    # Sign commits using GPG.
    # https://help.github.com/articles/signing-commits-using-gpg/
    gpgsign = true
```

#### `~/.vimrc.local`

Add custom vim keybindings, commands, etc.:

```vim
" custom key bindings
" swap current character with next character and retain cursor position
nnoremap <silent> gc xph
```

### Fork

If you decide to fork this project, do not forget to substitute my username with your own where applicable.

## File Overview

### Config files

- `.tmux.conf` - tmux
- `.tmux` - tmux "profiles"
- `.vim`, `.vimrc`, `.vimrc.local` - vim
- `.inputrc` - input prompt behavior (`readline`)

#### Bash

- `.aliases` - aliases
- `.bash_profile` - sources other files, sets shell options and autocompletion
- `.exports` - exports
- `.prompt` - prompt
- `.bashrc` - sources `.bash_profile`
- `.local` - optional local config
- `.functions` - functions
- `.path` - path

Bash file sourcing chain:

```
.bashrc
└── .bash_profile
    ├── .path
    ├── .prompt
    ├── .exports
    ├── .aliases
    ├── .functions
    └── .local
```

#### `git`

- `.gitattributes`
- `.gitconfig`
- `.gitconfig.local` - optional local config

### Miscellaneous

- install script that has not be written yet

## Acknowledgements

Inspiration and code was taken from many sources, including:

- [Cătălin Mariș](https://github.com/alrra/dotfiles)
- [Mathias Bynens](https://github.com/mathiasbynens/dotfiles)
- [Nicolas Gallagher](https://github.com/necolas/dotfiles)
- [Paul Irish](https://github.com/paulirish/dotfiles)
- [Jessie Frazelle](https://github.com/jessfraz/dotfiles)

[terminal-screenshot]: https://user-images.githubusercontent.com/11254125/67124992-7541c880-f1b9-11e9-9283-2d54be9d8569.png
