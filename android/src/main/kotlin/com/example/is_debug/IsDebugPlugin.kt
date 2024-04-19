package com.example.is_debug

import IsDebugHostApi
import android.content.Context
import android.content.pm.ApplicationInfo

import io.flutter.embedding.engine.plugins.FlutterPlugin

/** IsDebugPlugin */
class IsDebugPlugin : FlutterPlugin, IsDebugHostApi {
    private var context: Context? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        IsDebugHostApi.setUp(flutterPluginBinding.binaryMessenger, this)
        context = flutterPluginBinding.applicationContext
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        IsDebugHostApi.setUp(binding.binaryMessenger, null)
        context = null
    }

    override fun getPlatformVersion(): String {
        return "Android ${android.os.Build.VERSION.RELEASE}"
    }

    override fun isDebugHost(): Boolean {
        context?.let {
            val ai = it.packageManager.getApplicationInfo(it.packageName, 0)
            return ai.flags and ApplicationInfo.FLAG_DEBUGGABLE != 0
        }
        return false
    }
}
