package com.example.flutter_application_pw19

import android.annotation.SuppressLint
import android.content.Context
import android.content.Intent
import android.graphics.Color
import android.view.Gravity
import android.view.View
import android.widget.TextView
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView

@SuppressLint("SetTextI18n")
class NativeView(context: Context, channel: MethodChannel, args: Map<String, Any>) : PlatformView {
    private val textView: TextView = TextView(context)

    private val eventIntentName = "BUTTON_TEXT_LENGTH_INTENT_NAME"
    private val eventIntentId = "BUTTON_TEXT_LENGTH_INTENT_ID"
    private val methodChannelId = "BUTTON_TEXT"


    init {
        textView.textSize = 16f
        textView.setTextColor(Color.BLACK)
        textView.gravity = Gravity.CENTER
        // Set the initial text if provided in the args
        val initialText = args["initialText"] as String

        if (initialText.isNotBlank()) {
            textView.text = initialText
        }
        channel.setMethodCallHandler { call, result ->
            if (call.method == methodChannelId) {
                textView.text = call.argument<String>("text").toString()
                result.success("${call.argument<String>("text").toString().length}")
            } else {
                result.success("method isn't recognized")
            }

        }

        textView.setOnClickListener {
            val intent = Intent(eventIntentName)
            intent.putExtra(eventIntentId, textView.text.length)
            context.sendBroadcast(intent)
        }
    }

    override fun getView(): View {
        return textView
    }

    override fun dispose() {
        // Cleanup or dispose if needed
    }
}