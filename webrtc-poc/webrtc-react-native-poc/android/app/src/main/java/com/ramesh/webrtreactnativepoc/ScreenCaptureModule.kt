package com.ramesh.webrtreactnativepoc

import android.app.Activity
import android.content.Intent
import android.media.projection.MediaProjectionManager
import android.os.Build
import androidx.annotation.RequiresApi
import com.facebook.react.bridge.*

@RequiresApi(Build.VERSION_CODES.LOLLIPOP)
class ScreenCaptureModule(reactContext: ReactApplicationContext) : ReactContextBaseJavaModule(reactContext), ActivityEventListener {

    private val REQUEST_CODE = 1000
    private var mediaProjectionManager: MediaProjectionManager = reactContext.getSystemService(ReactApplicationContext.MEDIA_PROJECTION_SERVICE) as MediaProjectionManager
    private var capturePromise: Promise? = null

    init {
        reactContext.addActivityEventListener(this)
    }

    override fun getName(): String {
        return "ScreenCapture"
    }

    @ReactMethod
    fun startScreenCapture(promise: Promise) {
        val currentActivity: Activity? = currentActivity
        if (currentActivity != null) {
            val captureIntent = mediaProjectionManager.createScreenCaptureIntent()
            currentActivity.startActivityForResult(captureIntent, REQUEST_CODE)
            capturePromise = promise
        } else {
            promise.reject("Activity doesn't exist")
        }
    }

    override fun onActivityResult(activity: Activity?, requestCode: Int, resultCode: Int, data: Intent?) {
        if (requestCode == REQUEST_CODE) {
            if (resultCode == Activity.RESULT_OK && data != null) {
                capturePromise?.resolve(data)
            } else {
                capturePromise?.reject("Screen capture permission denied")
            }
        }
    }

    override fun onNewIntent(intent: Intent?) {
        // Do nothing
    }
}
