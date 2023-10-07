package com.example.flutter_application_1
import Message
import MessageApi
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

private class PigeonMessageApiImplementation: MessageApi {
    override fun getMessage(text: String): Message {
        return Message(length = text.length.toLong(), initialText = text, inLowerCase = text.lowercase(), inUpperCase = text.uppercase())
    }


}

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        val api = PigeonMessageApiImplementation()
        MessageApi.setUp(flutterEngine.dartExecutor.binaryMessenger, api);
    }
}
