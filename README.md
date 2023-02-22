# Utopia flutter project template

1. Create a directory for the project.
1. Run `git init` in the directory.
1. Download this repository as .zip and extract it in the directory.
1. Pick a package name (must not contain '-' character) and replace `DART_PACKAGE_NAME` everywhere with it (Ctrl+Shift+R in IntelliJ).
1. Setup platforms: `flutter create --project-name={package name picked in the previous step} --org={prefix for platform packages, e.g. "io.utopiasoft"} --platforms={e.g. "android,ios"} .`.
1. Review dependencies in `pubspec.yaml`.
1. Cleanup this README file.
1. If `melos` is required:
    1. Create `packages/{name}` directory for the app and move everything except `.idea` directory and `mason` files to it.
    1. Add `melos.yaml` file according to the docs.

---

## Requirements

- Flutter SDK ([](https://docs.flutter.dev/get-started/install))
- Android SDK for Android builds (Easiest to install with [Android Studio](https://developer.android.com/studio))
- Xcode for iOS builds
- Melos (Install via: `flutter pub global activate melos`)
- Mason - optional  (Install via: `flutter pub global activate mason_cli`)

## Setting up development environment

```bash
$ flutter pub get
$ mason get # optional
```

## Code generation

Repository relies on code generation. It can be run in two modes:

1. `flutter pub run build_runner build` - Runs generation only once and exits. Good for CI.
2. `flutter pub run build_runner watch` - Runs generation at startup and re-runs it when any file changes. Good for development.

## Building

Before building, ensure that environment has been [set-up](#setting-up-development-environment) and [code generation](#code-generation) has been run.

Replace the following placeholders:

- `{BUILD_NAME}` - Version name, e.g. `1.0.1`.
- `{BUILD_NUMBER}` - Integer build number. MUST be larger than in the previous build.
- `{CONFIG}` - Environment configuration. Must be one of the [allowed values](#available-environment-configurations).
- `{TARGET}` - One of supported targets: `apk`, `appbundle`, `ipa`.

```bash
$ flutter build {TARGET} --build-name={BUILD_NAME} --build-number={BUILD_NUMBER} --dart-define=CONFIG={CONFIG}
```

Outputs can be found in:
- `apk`: `build/app/outputs/flutter-apk/app.apk`
- `appbundle`: `build/app/outputs/bundle/release/app-release.aab` 
- `ipa`: `build/iod/archive/Runner.xcarchive`

## Repository structure

TODO: include for project with less-obvious structure, e.g.:

```
|- bricks - Code generation templates used via mason
|- packages
|  |- protocol - Protocol definition
|  |- simulator - Simulator android app; embeds python simulator script from tools/simulator
|  |- mobile - ELEVATE mobile app
|- tools
   |- simulator - Simulator python script  
```

## Available environment configurations

TODO: include if needed

During building add: `--dart-define=CONFIG={configName}` where `{configName}` can be: 
