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

The stable formula installs the compiled executable from the matching GitHub
release for macOS or Linux, on Intel/AMD or ARM. No Go installation is needed.
`brew upgrade darron/tap/otgo` installs future releases; `--HEAD` is not supported.

After publishing the release binaries and checksums, go-opentunnel dispatches
[the tap's workflow](https://github.com/darron/homebrew-tap/actions/workflows/update-otgo.yml).
It verifies all four archives, installs and tests the native macOS binary, and
compares the installed executable byte for byte before publishing the formula.
Manual retries are supported; there is no scheduled polling. The dispatch uses
`HOMEBREW_TAP_TOKEN` with Actions write permission for this tap. Validation and
formula publishing use the tap's own Actions token.

## Brewfile

```ruby
tap "darron/tap"
brew "dbrain"
brew "otgo"
```

## Documentation

Run `brew help`, `man brew`, or read Homebrew's documentation:
https://docs.brew.sh
