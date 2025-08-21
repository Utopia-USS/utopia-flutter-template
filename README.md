# Utopia flutter project template

1. Create a directory for the project.
2. Run `git init` in the directory.
3. Download this repository as .zip and extract it in the directory.
4. Pick a package name (must not contain '-' character) and replace `DART_PACKAGE_NAME` everywhere with it (Ctrl+Shift+R
   in IntelliJ).
5. Setup FVM: `fvm use` (uses the version specified in the `.fvmrc` file)
6. Setup platforms: `fvm flutter create --project-name={package name picked in the previous step} --org={prefix for 
platform packages, e.g. "io.utopiasoft"} --platforms={e.g. "android,ios"} .`.
7. Review dependencies in `pubspec.yaml`.
8. Create localization sheet based on [`utopia_localization_generator` docs](https://pub.
   dev/packages/utopia_localization_generator) 
8. Cleanup this README file.
9. If `melos` is required:
10. Create `packages/{name}` directory for the app and move everything except `.idea` directory and `mason` files to
    it.
11. Add `melos.yaml` file according to the docs.

---

## Requirements

- FVM ([Install](https://fvm.app/documentation/getting-started))
- Flutter SDK (will be installed by FVM)
- Android SDK for Android builds (Easiest to install with [Android Studio](https://developer.android.com/studio))
- Xcode for iOS builds

## Setting up development environment

```bash
$ fvm dart pub get
$ mason get # optional
```

## Code generation

Repository relies on code generation. It can be run in two modes:

1. `fvm dart run build_runner build` - Runs generation only once and exits. Good for CI.
2. `fvm dart run build_runner watch` - Runs generation at startup and re-runs it when any file changes. Good for
   development.

## Building

Before building, ensure that environment has been [set-up](#setting-up-development-environment)
and [code generation](#code-generation) has been run.

Replace the following placeholders:

- `{BUILD_NAME}` - Version name, e.g. `1.0.1`.
- `{BUILD_NUMBER}` - Integer build number. MUST be larger than in the previous build.
- `{CONFIG}` - Environment configuration. Must be one of the [allowed values](#available-environment-configurations).
- `{TARGET}` - One of supported targets: `apk`, `appbundle`, `ipa`.

```bash
$ fvm flutter build {TARGET} --build-name={BUILD_NAME} --build-number={BUILD_NUMBER} --dart-define=CONFIG={CONFIG}
```

Outputs can be found in:

- `apk`: `build/app/outputs/flutter-apk/app.apk`
- `appbundle`: `build/app/outputs/bundle/release/app-release.aab`
- `ipa`: `build/iod/archive/Runner.xcarchive`

## Repository structure

TODO: include for project with less-obvious structure, e.g.:

```
|- packages
|  |- protocol - Protocol definition
|  |- simulator - Simulator android app; embeds python simulator script from tools/simulator
|  |- mobile - mobile app
|- tools
   |- simulator - Simulator python script  
```

## Available environment configurations

TODO: include if needed

During building add: `--dart-define=CONFIG={configName}` where `{configName}` can be: 
