# أقوَم (Aqwam)

Aqwam is a free, ad-free, offline-first Islamic companion for Android, with an
iOS-ready Flutter foundation. Arabic is the primary language and English is
also supported.

## Run

Install Flutter 3.44 or newer, then run:

```shell
flutter pub get
flutter run
```

The Android application id is `io.github.salah248.aqwam`.

## Test

```shell
dart format --set-exit-if-changed .
flutter analyze
flutter test --coverage
```

## Contribute

Read [CONTRIBUTING.md](CONTRIBUTING.md), the [engineering standards](docs/standards/)
and the [project plan](docs/plan/aqwam-plan.md) before making a change. Work on
a focused branch and open a pull request; do not push directly to `main`.

Religious content is added only through the verified content pipeline. See
[docs/SOURCES.md](docs/SOURCES.md) for source and attribution requirements.
