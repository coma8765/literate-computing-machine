all:

build_runner:
	flutter pub run build_runner build --delete-conflicting-outputs

clean:
	flutter clean

pre-commit:
	dart format .
	flutter analyze

pre-commit-check:
	dart format . --set-exit-if-changed
	flutter analyze
