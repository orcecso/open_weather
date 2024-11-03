# Makefile for open weather

# Clean Flutter project and fetch dependencies
clean:
	flutter clean
	flutter pub get
	cd ios && pod update && cd ..
	dart run build_runner clean
	dart run build_runner build --delete-conflicting-outputs

env:
	dart run build_runner clean
	dart run build_runner build --delete-conflicting-outputs

prod_android:
	fvm flutter clean
	fvm flutter pub get
	fvm flutter build appbundle --release -t lib/main_prod.dart

qa_android:
	fvm flutter clean
	fvm flutter pub get
	fvm flutter build appbundle --release -t lib/main_qa.dart

prod_ios:
	fvm flutter clean
	fvm flutter pub get
	fvm flutter build ipa --release -t lib/main_prod.dart
	
qa_ios:
	fvm flutter clean
	fvm flutter pub get
	fvm flutter build ipa --release -t lib/main_qa.dart

# apk only not aab

qa_android_apk:
	fvm flutter clean
	fvm flutter pub get
	fvm flutter build apk --release -t lib/main_qa.dart


prod_android_apk:
	fvm flutter clean
	fvm flutter pub get
	fvm flutter build apk --release -t lib/main_prod.dart


# Add more commands here

both_qa:
	fvm flutter clean
	fvm flutter pub get
	fvm flutter build appbundle --release -t lib/main_qa.dart
	fvm flutter build ipa --release -t lib/main_qa.dart

both_prod:
	fvm flutter clean
	fvm flutter pub get
	fvm flutter build appbundle --release -t lib/main_prod.dart
	fvm flutter build ipa --release -t lib/main_prod.dart