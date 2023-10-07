package com.example.fluttermoduleandroid

import android.os.Bundle
import android.widget.Button
import androidx.appcompat.app.AppCompatActivity
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.plugin.common.MethodChannel
import kotlin.random.Random

private const val FLUTTER_ENGINE_ID = "flutter_module"
private const val METHOD_CHANNEL_ID = "PLATFORM_RANDOM_VALUE_METHOD"
private const val METHOD_ID = "RANDOM_VALUE"

private lateinit var channel: MethodChannel

class MainActivity : AppCompatActivity() {
    lateinit var flutterEngine : FlutterEngine
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        // Instantiate a FlutterEngine
        flutterEngine = FlutterEngine(this)

        // Start executing Dart code to pre-warm the FlutterEngine
        flutterEngine.dartExecutor.executeDartEntrypoint(
            DartExecutor.DartEntrypoint.createDefault()
        )

        // Cache the FlutterEngine to be used by FlutterActivity
        FlutterEngineCache
            .getInstance()
            .put(FLUTTER_ENGINE_ID, flutterEngine)

        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, METHOD_CHANNEL_ID)
        channel.setMethodCallHandler { call, result ->
            if (call.method == METHOD_ID) {
                result.success((1..500).random())
            } else {
                result.success("method isn't recognized")
            }

        }
        val myButton = findViewById<Button>(R.id.myButton)
        myButton.setOnClickListener {
            startActivity(
                FlutterActivity
                    .withCachedEngine(FLUTTER_ENGINE_ID)
                    .build(this)
            )
        }
    }
}

