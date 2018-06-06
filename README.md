# spacemacs

Much credit goes to the orignal author @fernandomayer for putting the upstream repo together. It has been an extremely useful resource. 

## Spacemacs configuration files and private layers

[Spacemacs] is a community driven configuration distribution to power up your
[Emacs]. Some selling points of Spacemacs: 

* Modern interface, that is easier to learn as you go than [Vim] or Emacs.
* Many smart defaults, so you don't have to struggle to get your `.emacs` the way you want.
* Configuration model of Spacemacs is based on *layers*, which makes things much more modular and organised. 
* Vim has influenced Spacemacs heavily, so Vim users can use keybindings they were used to,
with the additional power of Emacs.

This repository contains my `.spacemacs` file (named `spacemacs.el`) and
some private layers.

Layers are in the `private` directory, and now they are:

- `ess`: This is a clone of the original Spacemacs ess layer
  (available at `layers/+lang/ess`), but it includes the following
  modifications:
  - ESS underscore bullshittery is disabled.
  - Adds a function to insert `%>%` and add a newline bound to `"C-'"`
  - Adds a function to insert `<- ` bound to `"C-\""`
  - Adds a function to inser an RMarkdown chunk bound to `"C-c i"`
  - Adds a function to evaluate the current word bound to `"C-c r"` or `", r"`.
  - Binds a function to evaluate the current para or function to `", e"`.
  - Adds major mode key combos for `devtools` under `d` prefix
  - Adds major mode key combos for help under `h` prefix
  
- `polymode`: Creates a layer to install and configure [polymode],
  adding support for R markdown (`Rmd`) files in Spacemacs.
  (Note that ess already supports `Rnw` files, and this is enabled by
  default in Spacemacs).

These layers are enabled by moving them to `~/emacs.d/private` and adding
these lines at `dotspacemacs-configuration-layers` in `.spacemacs`

```
ess
polymode
```

## Miscelaneous

[polymode]: https://github.com/vspinu/polymode
[R Coding Standards]: https://cran.r-project.org/doc/manuals/R-ints.html#R-coding-standards
[Spacemacs]: http://spacemacs.org/
[Emacs]: https://www.gnu.org/software/emacs/
[Vim]: http://www.vim.org/
