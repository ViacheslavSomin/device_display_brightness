package com.sominviacheslav.device_display_brightness

import android.app.Activity
import android.provider.Settings
import android.view.WindowManager
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result


class DeviceDisplayBrightnessPlugin : FlutterPlugin, ActivityAware, MethodCallHandler {

    private lateinit var channel: MethodChannel
    private var activity: Activity? = null

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, METHOD_CHANNEL)
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "getBrightness" -> result.success(getBrightness())
            "setBrightness" -> {
                val brightness: Double = call.argument("brightness")!!
                setBrightness(brightness)
                result.success(null)
            }
            "resetBrightness" -> {
                resetBrightness()
                result.success(null)
            }
            "isKeptOn" -> {
                result.success(isKeptOn())
            }
            "keepOn" -> {
                val enabled: Boolean = call.argument("enabled")!!
                keepOn(enabled)
                result.success(null)
            }
            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        this.activity = binding.activity
    }


    override fun onDetachedFromActivity() {
        this.activity = null
    }

    override fun onDetachedFromActivityForConfigChanges() {}

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {}


    private fun getBrightness(): Float {
        activity?.let {
            var result: Float = it.window?.attributes?.screenBrightness ?: 0f

            // if result < 0, then application is using the system brightness
            if (result < 0) {
                result = try {
                    Settings.System.getInt(
                        it.contentResolver,
                        Settings.System.SCREEN_BRIGHTNESS
                    ) / 255.toFloat()
                } catch (e: Exception) {
                    0.0f
                }
            }
            return result

        } ?: return 0f
    }

    private fun setBrightness(brightness: Double) {
        if (activity == null) return
        if (activity!!.window == null) return

        val layoutParams: WindowManager.LayoutParams = activity!!.window!!.attributes
        layoutParams.screenBrightness = brightness.toFloat()

        activity?.window?.attributes = layoutParams
    }

    private fun resetBrightness() {
        if (activity == null) return
        if (activity!!.window == null) return

        val layoutParams: WindowManager.LayoutParams = activity!!.window!!.attributes
        layoutParams.screenBrightness = WindowManager.LayoutParams.BRIGHTNESS_OVERRIDE_NONE

        activity?.window?.attributes = layoutParams
    }

    private fun isKeptOn(): Boolean {
        val flags: Int? = activity?.window?.attributes?.flags

        return (flags != null) && (flags and WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON != 0)
    }

    private fun keepOn(enabled: Boolean) {
        if (enabled) {
            activity?.window?.addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)
        } else {
            activity?.window?.clearFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON)
        }
    }

    companion object {
        const val METHOD_CHANNEL = "github.com/SVD13/device_display_brightness"
    }

}
