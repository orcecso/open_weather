# Makefile for open weather

# Clean Flutter project and fetch dependencies
clean:
	fvm install 3.24.3
	fvm use 3.24.3
	flutter clean
	flutter pub get
	cd ios && pod update && cd ..
	dart run build_runner clean
	dart run build_runner build --delete-conflicting-outputs

build_apk:
	fvm flutter clean
	fvm flutter pub get
	fvm flutter build apk --release -t lib/main.dart