package com.example.flutter_application_pw19

import android.annotation.SuppressLint
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val androidViewId = "INTEGRATION_ANDROID"
    private val methodChannelId = "BUTTON_TEXT_METHOD"
    private val eventsChannel = "BUTTON_TEXT_LENGTH_EVENT"
    private val eventIntentName = "BUTTON_TEXT_LENGTH_INTENT_NAME"
    private val eventIntentId = "BUTTON_TEXT_LENGTH_INTENT_ID"

    private var receiver: BroadcastReceiver? = null

    private lateinit var channel: MethodChannel
    @SuppressLint("ResourceType")
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, methodChannelId)
        flutterEngine.platformViewsController.registry.registerViewFactory(
            androidViewId, NativeViewFactory(channel)
        )

        EventChannel(flutterEngine.dartExecutor, eventsChannel).setStreamHandler(
            object : EventChannel.StreamHandler{
                @SuppressLint("UnspecifiedRegisterReceiverFlag")
                override fun onListen(arguments: Any?, events: EventChannel.EventSink) {
                    receiver = this@MainActivity.createReceiver(events)
                    applicationContext.registerReceiver(receiver, IntentFilter(eventIntentName))
                }

                override fun onCancel(arguments: Any?) {
                    receiver = null
                }
        })
    }

    fun createReceiver(events: EventChannel.EventSink): BroadcastReceiver {
        return object : BroadcastReceiver() {
            override fun onReceive(context: Context?, intent: Intent) {
                events.success(intent.getIntExtra(eventIntentId, 0))
            }
        }
    }
}
