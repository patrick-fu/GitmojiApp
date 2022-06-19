# GitmojiApp

A Gitmoji app for macOS, Linux, and Windows.

## What is this

GitmojiApp is a simple desktop app that allows you to add a [Gitmoji](https://gitmoji.dev) to your git commit messages.

## Installation

### Download

Download the latest prebuilt binary from [Github release](https://github.com/patrick-fu/GitmojiApp/releases)

> Note that the  macOS App is not notarized by Apple, so you should codesign it by yourself, otherwise you can not open it.

```bash
# Unzip the artifact and cd into the folder
$ codesign -dfs - ./GitmojiApp.app
```

### Compile by yourself

```bash
# flutter v3.0.0 is required
$ flutter pub get

# On macOS
$ flutter build macos

# On Linux
$ flutter build linux

# On Windows
$ flutter build windows
```
