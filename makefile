# Makefile for open weather

# Clean Flutter project and fetch dependencies
clean:
	flutter clean
	flutter pub get
	cd ios && pod update && cd ..
	dart run build_runner clean
	dart run build_runner build --delete-conflicting-outputs
