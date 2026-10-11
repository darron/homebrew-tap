# Darron's Homebrew Tap

Homebrew formulae for tools published by Darron.

## Install dbrain

```sh
brew install darron/tap/dbrain
```

Or tap once and install by formula name:

```sh
brew tap darron/tap
brew install dbrain
```

## Install otgo

```sh
brew install darron/tap/otgo
brew test darron/tap/otgo
```

The stable formula builds the CLI from the latest published release source.
Use `brew install --HEAD darron/tap/otgo` for main. Only the CLI is installed;
Go is a build dependency. Future stable releases update the formula automatically
from [the tap's workflow](https://github.com/darron/homebrew-tap/actions/workflows/update-otgo.yml).
It runs when go-opentunnel publishes a stable release and supports manual runs;
there is no scheduled polling. The source release hook needs `HOMEBREW_TAP_TOKEN`
with Actions write permission for this tap. Validation and formula publishing use
the tap's own Actions token.

## Brewfile

```ruby
tap "darron/tap"
brew "dbrain"
brew "otgo"
```

## Documentation

Run `brew help`, `man brew`, or read Homebrew's documentation:
https://docs.brew.sh
