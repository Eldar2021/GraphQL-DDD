/*
flutter build apk --target lib/main_production.dart --obfuscate --split-debug-info=./obs_cpurier
Run the command "flutter build apk --target lib/main_production.dart" for apk file
Run the command "flutter run apk --target lib/main_production.dart" for run project
flutter build apk --target lib/main_production.dart --obfuscate --split-debug-info=./obs_cpurier
flutter build appbundle --obfuscate --split-debug-info=./obs_cpurier
flutter build ios --obfuscate --split-debug-info=./obs_cpurier

    buildTypes {
        release {
            signingConfig signingConfigs.debug
            // signingConfig signingConfigs.release
            minifyEnabled true
            proguardFiles getDefaultProguardFile('proguard-android.txt')
        }
        debug {
            signingConfig signingConfigs.debug
        }
    }
*/
