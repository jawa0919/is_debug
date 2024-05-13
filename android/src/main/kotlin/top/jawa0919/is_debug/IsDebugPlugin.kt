package top.jawa0919.is_debug

import android.content.Context
import android.content.pm.ApplicationInfo
import android.net.ConnectivityManager
import android.net.NetworkCapabilities
import android.os.Build
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.io.File

/** IsDebugPlugin */
class IsDebugPlugin : FlutterPlugin, MethodCallHandler {
    private lateinit var channel: MethodChannel

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "is_debug.MethodChannel")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext;
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        context = null
    }

    private var context: Context? = null

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if (call.method == "getHostPlatformName") {
            result.success("Android${Build.VERSION.RELEASE}")
        } else if (call.method == "getHostPlatformVersion") {
            result.success("${Build.VERSION.SDK_INT}")
        } else if (call.method == "isDebugHost") {
            context?.let {
                val ai = it.packageManager.getApplicationInfo(it.packageName, 0)
                if (ai.flags and ApplicationInfo.FLAG_DEBUGGABLE != 0) {
                    result.success("isDebugHost")
                } else {
                    result.success("")
                }
            } ?: run {
                result.success("")
            }
        } else if (call.method == "isSimulatorHost") {
            val isSimulator: Boolean =
                ((Build.BRAND.startsWith("generic") && Build.DEVICE.startsWith("generic"))
                        || Build.FINGERPRINT.startsWith("generic")
                        || Build.FINGERPRINT.startsWith("unknown")
                        || Build.HARDWARE.contains("goldfish")
                        || Build.HARDWARE.contains("ranchu")
                        || Build.MODEL.contains("google_sdk")
                        || Build.MODEL.contains("Emulator")
                        || Build.MODEL.contains("Android SDK built for x86")
                        || Build.MANUFACTURER.contains("Genymotion")
                        || Build.PRODUCT.contains("sdk")
                        || Build.PRODUCT.contains("vbox86p")
                        || Build.PRODUCT.contains("emulator")
                        || Build.PRODUCT.contains("simulator"))
            result.success(if (isSimulator) "isSimulatorHost" else "")
        } else if (call.method == "isRootHost") {
            val locations = arrayOf(
                "/system/bin/",
                "/system/xbin/",
                "/sbin/",
                "/system/sd/xbin/",
                "/system/bin/failsafe/",
                "/data/local/xbin/",
                "/data/local/bin/",
                "/data/local/",
                "/system/sbin/",
                "/usr/bin/",
                "/vendor/bin/"
            )
            for (location in locations) {
                if (File(location + "su").exists()) {
                    result.success("isRootHost")
                    return
                }
            }
            result.success("")
        } else if (call.method == "isRunningProxy") {
            val proxyHost = System.getProperty("http.proxyHost")?.isNotEmpty() ?: false
            val proxyPort = System.getProperty("http.proxyPort")?.toIntOrNull() !== null
            if (proxyHost && proxyPort) {
                result.success("isRunningProxy")
            } else {
                result.success("")
            }
        } else if (call.method == "isRunningVpn") {
            context?.let {
                val cm = it.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                    val ca = cm.getNetworkCapabilities(cm.activeNetwork)
                    if (ca?.hasTransport(NetworkCapabilities.TRANSPORT_VPN) == true) {
                        result.success("isRunningVpn")
                    } else {
                        result.success("")
                    }
                } else {
                    if (getNetworkVpnLegacy(cm)) {
                        result.success("isRunningVpn")
                    } else {
                        result.success("")
                    }
                }
            } ?: run {
                result.success("")
            }
        } else {
            result.notImplemented()
        }
    }

    @Suppress("deprecation")
    private fun getNetworkVpnLegacy(cm: ConnectivityManager): Boolean {
        val info = cm.activeNetworkInfo
        if (info == null || !info.isConnected) {
            return false
        }
        if (info.type == ConnectivityManager.TYPE_VPN) {
            return true
        }
        return false
    }
}
