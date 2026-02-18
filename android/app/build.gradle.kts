import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.ifriend.app"
    compileSdk = 36
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = "17"
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.ifriend.app"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = 25
        targetSdk = 36
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") {
            val keystoreProperties = Properties()
            val keystorePropertiesFile = rootProject.file("key.properties")
            if (keystorePropertiesFile.exists()) {
                keystoreProperties.load(FileInputStream(keystorePropertiesFile))
            }
            keyAlias = keystoreProperties.getProperty("keyAlias")
            keyPassword = keystoreProperties.getProperty("keyPassword")
            storeFile = if (keystoreProperties.getProperty("storeFile") != null) {
                rootProject.file(keystoreProperties.getProperty("storeFile"))
            } else {
                null
            }
            storePassword = keystoreProperties.getProperty("storePassword")
        }

        // Configure debug signing config from android/debug_key.properties, but don't create a duplicate
        val debugProps = Properties()
        val debugPropsFile = rootProject.file("debug_key.properties")
        if (debugPropsFile.exists()) {
            debugProps.load(FileInputStream(debugPropsFile))
        }

        val existingDebug = signingConfigs.findByName("debug")
        if (existingDebug != null) {
            existingDebug.apply {
                keyAlias = debugProps.getProperty("keyAlias") ?: "androiddebugkey"
                keyPassword = debugProps.getProperty("keyPassword") ?: "android"
                if (debugProps.getProperty("storeFile") != null) {
                    storeFile = rootProject.file(debugProps.getProperty("storeFile"))
                }
                storePassword = debugProps.getProperty("storePassword") ?: "android"
            }
        } else {
            create("debug") {
                keyAlias = debugProps.getProperty("keyAlias") ?: "androiddebugkey"
                keyPassword = debugProps.getProperty("keyPassword") ?: "android"
                storeFile = if (debugProps.getProperty("storeFile") != null) {
                    rootProject.file(debugProps.getProperty("storeFile"))
                } else {
                    null
                }
                storePassword = debugProps.getProperty("storePassword") ?: "android"
            }
        }
    }

    buildTypes {
        release {
            // Using production release signing
            signingConfig = signingConfigs.getByName("release")
        }

        // Force debug builds to use the shared debug signing key above. This will not change release builds.
        debug {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}
