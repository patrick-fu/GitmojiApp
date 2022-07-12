# Changelog

<a name="1.0.0"></a>

## 1.0.0 (2022-06-22)

### Added

- ✨ Add an &quot;always on top&quot; button on title bar [[0c90cdf](https://github.com/patrick-fu/GitmojiApp/commit/0c90cdfef0cbde888d1faef333b67dd950ba07ec)]
- ✨ Add a settings page [[1a8568d](https://github.com/patrick-fu/GitmojiApp/commit/1a8568de0fca3de0228052c5e517b8c2dbfe32cf)]
- ✨ Support filtering the gitmoji rows based on the input search text [[7cbb997](https://github.com/patrick-fu/GitmojiApp/commit/7cbb997751f0bb8be735ce9846e6e645fe2631c8)]
- ➕ Add dependency &quot;provider&quot; [[c5f6298](https://github.com/patrick-fu/GitmojiApp/commit/c5f62984960736ca3ea18b36185da449b128be5f)]
- ✨ Support fetching gitmoji data source from github [[bea9846](https://github.com/patrick-fu/GitmojiApp/commit/bea9846e94900058e34016ee0b3a2c0977e7c6a4)]
- 🎉 Initialize the flutter app project [[c590569](https://github.com/patrick-fu/GitmojiApp/commit/c59056930d93dbaade03eb4e5f67fc4c9664523c)]
- 🎉 Initial commit [[a4fc0fe](https://github.com/patrick-fu/GitmojiApp/commit/a4fc0fe3c349133d097dcddf9c82fad3f6af32f9)]

### Changed

- 🔧 Update Windows app resource configuration [[8acc906](https://github.com/patrick-fu/GitmojiApp/commit/8acc906c0c18b833a7fd119210422ef8339f2bd9)]
- 🔧 Add inno setup wizard script for make windows app installer [[e7ca530](https://github.com/patrick-fu/GitmojiApp/commit/e7ca5303c4e154bf0732e9f310d5ea249c422a19)]
- ⬆️ Upgrade icons_launcher, then update windows app icon to a multiple resolution ico [[4dd0c9a](https://github.com/patrick-fu/GitmojiApp/commit/4dd0c9adbe278bbdae0d73d5be9c34675e947bf8)]
- 🔧 Packaging Windows app with msix [[8a1c5a4](https://github.com/patrick-fu/GitmojiApp/commit/8a1c5a435d5e6ec3d936bd6b978898481faa1d99)]
- 🔧 Set macOS deployment target to 10.15 to reduce package size [[59a7758](https://github.com/patrick-fu/GitmojiApp/commit/59a7758d727729ef85ad9347262e54f0c85b7069)]
- 🔧 Update macOS project, fix the app name and bundle id [[99f0180](https://github.com/patrick-fu/GitmojiApp/commit/99f01804ea79ad43e4217ecf36643364c9976a37)]
- 🗃️ Persistently save configuration data to support setting the copy value type of gitmoji [[1a37e04](https://github.com/patrick-fu/GitmojiApp/commit/1a37e04f8e8eb2ff9219a94cff145ae0a09ed810)]
- 🍱 Add application icons (prefer Big Sur round style on desktop) [[0d32fab](https://github.com/patrick-fu/GitmojiApp/commit/0d32fab8267ae890c56700b31dd2c393f3d4147c)]
- 💄 Add a search bar and adjust the gitmoji row style [[35ebe8e](https://github.com/patrick-fu/GitmojiApp/commit/35ebe8e878598597542d097b06bf95ba7431e630)]
- 🔧 Update project configuration files [[4b43b02](https://github.com/patrick-fu/GitmojiApp/commit/4b43b02787bbe1893f7f75af07b444ceed9bc749)]
- 💄 Add basic home page UI elements [[cb37c0d](https://github.com/patrick-fu/GitmojiApp/commit/cb37c0da07e357fad284bff28296321a62b51fde)]
- ⚡ Persistently cache Gitmoji data [[7fc645b](https://github.com/patrick-fu/GitmojiApp/commit/7fc645b88ef61a90826a9df62e0e2f87ce676d63)]

### Fixed

- 🐛 Fix the windows icon, remove the low resolution part of the ico file [[10745f5](https://github.com/patrick-fu/GitmojiApp/commit/10745f59927f6235d78d959f6c288e663bf3c59c)]
- 🐛 Fix the windows app executable name [[dac0363](https://github.com/patrick-fu/GitmojiApp/commit/dac0363796dbd7aeca1f0ec845ebe45bfc3c308f)]
- 🐛 Fix the issue that the hidden style title bar could not be dragged on Windows [[3704821](https://github.com/patrick-fu/GitmojiApp/commit/3704821bc77ef401c7109247342fce03c01e6b53)]
- 🐛 Fix the issue that the shared preferences instance not initialized when accessing data [[3af624d](https://github.com/patrick-fu/GitmojiApp/commit/3af624d823298019c7350a2c7f25506160aeee81)]

### Miscellaneous

- 📝 Update README [[390c180](https://github.com/patrick-fu/GitmojiApp/commit/390c180bd11c9c8269840d158b16d8a3448a9d96)]
- 👷 Fix Windows build pipeline, use inno setup to make installer exe [[aa94243](https://github.com/patrick-fu/GitmojiApp/commit/aa942435862c97738b84662a9914f9103c7d8603)]
- 👷 Build and archive Windows app with Github Actions [[fc08129](https://github.com/patrick-fu/GitmojiApp/commit/fc08129ce3cb7f3b505e7a6ef92808aa166c5912)]
- Merge branch &#x27;main&#x27; into feature/ci [[c2a1cfa](https://github.com/patrick-fu/GitmojiApp/commit/c2a1cfa56ccd1c2433ed647768f235d4ca35f611)]
- 🚩 Display app version on settings page [[7a60a6b](https://github.com/patrick-fu/GitmojiApp/commit/7a60a6b9d6eb53b99baabfd60f419b9d891c2b56)]
- 🚩 Add a button to exit the app in the settings page [[66df84f](https://github.com/patrick-fu/GitmojiApp/commit/66df84f2cb52795c1dc13ee6f4fc12c53f4e9ff7)]
- 👷 Fix the wrong archive artifact path [[7db29ca](https://github.com/patrick-fu/GitmojiApp/commit/7db29cad7179954d92070cc777f6621c25e8e8ec)]
- 📝 Add installation guide for macOS App [[d3138eb](https://github.com/patrick-fu/GitmojiApp/commit/d3138eb5a99a8a0f31af8d6b20b3c3cb141037cb)]
- 👷 Fix the issue that the symlink is invalid when packaging macOS app [[ce290b7](https://github.com/patrick-fu/GitmojiApp/commit/ce290b71e8a2c46c35b5a0e2aa23ea11b6c398ed)]
- 👷 Add Github Actions workflow for CI [[419fd60](https://github.com/patrick-fu/GitmojiApp/commit/419fd607398512e0247c8ff5d2eb444064e7437e)]
- 📝 Update README [[976584d](https://github.com/patrick-fu/GitmojiApp/commit/976584d219dcbb9c298caf31108e72fbc939485e)]
- 🚩 Add a clear text button for the search bar text field [[a660834](https://github.com/patrick-fu/GitmojiApp/commit/a6608344dc2a352e5711dfc84b448792e12ac52e)]
- 🚩 Customize window style, set minimum window size and remove the title bar [[7c31b2b](https://github.com/patrick-fu/GitmojiApp/commit/7c31b2b19475e4de53b0bc2142ad47918d2b5f93)]
- 🚩 Prefer loading local &quot;gitmojis&quot; json data over remote github data to speed up launch time [[d4957d8](https://github.com/patrick-fu/GitmojiApp/commit/d4957d8ac9c1b75cb3d5c2dd34d23b1d462254d5)]
- 🚩 Support click to copy emoji to clipboard [[1ae8530](https://github.com/patrick-fu/GitmojiApp/commit/1ae8530955f9327a077c653cad1ccd521765bd83)]
