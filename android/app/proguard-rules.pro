-keepclassmembers class * {
    @android.webkit.JavascriptInterface <methods>;
}

-keepattributes JavascriptInterface
-keepattributes *Annotation*



-optimizations !method/inlining/*
-keepclasseswithmembers class * {*;}