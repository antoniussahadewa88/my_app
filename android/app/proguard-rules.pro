# Keep all Google Tink classes
-keep class com.google.crypto.tink.** { *; }
-dontwarn com.google.crypto.tink.**

# Keep Error Prone annotations
-keep class com.google.errorprone.annotations.** { *; }

# Keep JSR annotations
-keep class javax.annotation.** { *; }
-dontwarn javax.annotation.**

# Keep HttpTransport dependencies
-keep class com.google.api.client.** { *; }
-dontwarn com.google.api.client.**

# Keep Joda Time
-keep class org.joda.time.** { *; }
-dontwarn org.joda.time.**
