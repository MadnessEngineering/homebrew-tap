# MadnessEngineering Homebrew tap

Homebrew casks for Madness Engineering apps.

```sh
brew install --cask madnessengineering/tap/madness-desktop
```

| Cask | App | Platform |
|---|---|---|
| `madness-desktop` | [Madness Desktop](https://github.com/MadnessEngineering/madnessDesktop), a GitHub Desktop fork | macOS 13+, Apple Silicon |

Homebrew only loads casks from taps you trust. Installing by the full name
above trusts that cask for you. If you `brew tap madnessengineering/tap` and use
the short name, run `brew trust --cask madnessengineering/tap/madness-desktop`
first.

## Madness Desktop

The build is unsigned and not notarized, so macOS blocks it the first time you
open it. Clear the quarantine flag:

```sh
xattr -dr com.apple.quarantine "/Applications/Madness Desktop.app"
```

or try to open it once, then click **Open Anyway** under System Settings →
Privacy & Security.

If a from-source build is already in `/Applications`, add `--force` to replace
it. The cask also links the `madhub` command-line tool. Update with
`brew upgrade --cask madness-desktop`, not `madhub upgrade`, so Homebrew keeps
track of the installed version.

`brew uninstall --cask madness-desktop` removes the app and keeps your settings
in `~/Library/Application Support/Madness Desktop`. Add `--zap` to delete those
too.

## Maintaining

After publishing a Madness Desktop release:

```sh
scripts/bump-madness-desktop.sh 0.1.4
brew audit --cask --online madnessengineering/tap/madness-desktop
git commit -am "madness-desktop 0.1.4" && git push
```
