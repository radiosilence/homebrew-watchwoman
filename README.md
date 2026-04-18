# homebrew-watchwoman

Homebrew tap for [watchwoman](https://github.com/radiosilence/watchwoman) —
a drop-in watchman replacement that doesn't eat your RAM.

## Install

```sh
brew install radiosilence/watchwoman/watchwoman
```

This installs both `watchwoman` and a `watchman` alias, so every tool
that expects `watchman` on `$PATH` resolves to watchwoman instead.

## Uninstall

```sh
brew uninstall watchwoman
brew untap radiosilence/watchwoman
```

## Switching from facebook/fb's watchman

See [`docs/REPLACING_WATCHMAN.md`](https://github.com/radiosilence/watchwoman/blob/main/docs/REPLACING_WATCHMAN.md)
in the main repo.
