all:

build_runner:
	flutter pub run build_runner build --delete-conflicting-outputs

clean:
	flutter clean
