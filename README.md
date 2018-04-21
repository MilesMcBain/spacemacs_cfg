# spacemacs

Much credit goes to the orignal author @fernandomayer for putting the upstream repo together. It has been an extremely useful resource. 

## Spacemacs configuration files and private layers

[Spacemacs] is a set of configurations available to power up your
[Emacs], the best text editor in the world. Spacemacs brings a modern
interface, and many smart defaults, so you don't have to struggle to let
your `.emacs` the way you want (although many like the challenge).
Anyway, Spacemacs let you configure it the same old way, but based on
*layers*, which makes things much more organized. By the way, Spacemacs
even let [Vim] users to use keybindings they were used to, but
with the power of Emacs.

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
  - Adds a function to evaluate the current word bount to `"C-c r"`.
  
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
