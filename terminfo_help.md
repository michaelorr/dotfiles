To enable italics requires updating the terminfo database. Terminfo enables programs to use the term
inal in a device-independent manner. For us, this means that it allows applications to lookup the correct
escape codes for displaying italics. If the terminfo database has the correct escape codes present in
the database, italics are displayed. If not? No italics.

Now, we need a few files describing how to mark words as being in italics. In total, there are three
different files that provide the required escape codes for tmux, tmux with 256 colour support, and
xterm with 256 colour support. By adding all three to the terminfo database, you will have italics
available everywhere you use Vim.

Create the following three files somewhere on your system:

`tmux.terminfo`
```
tmux|tmux terminal multiplexer,
  sitm=\E[3m, ritm=\E[23m,
  smso=\E[7m, rmso=\E[27m,
  use=screen,
tmux-256color.terminfo
```

`tmux-256color.terminfo`
```
tmux-256color|tmux with 256 colors,
  sitm=\E[3m, ritm=\E[23m,
  smso=\E[7m, rmso=\E[27m,
  use=screen-256color,
xterm-256color.terminfo
```

`xterm-256color.terminfo`
```
xterm-256color|xterm with 256 colors and italic,
  sitm=\E[3m, ritm=\E[23m,
  use=xterm-256color,
```

Now, we need to compile these files and add them to the terminfo database using the terminfo compiler,
available with the tic command. This command requires the path to your terminfo database, and the
file to compile.

$ tic -o $HOME/.terminfo tmux.terminfo
$ tic -o $HOME/.terminfo tmux-256color.terminfo
$ tic -o $HOME/.terminfo xterm-256color.terminfo

-OR-

$ tic tmux.terminfo
$ tic tmux-256color.terminfo
$ tic xterm-256color.terminfo

After executing commands, italics works in Vim. As an optional addition, you can configure your Vim
colour scheme to format any code comments in italics. You can do this by adding the following line
to your .vimrc file:

`highlight Comment cterm=italic`
