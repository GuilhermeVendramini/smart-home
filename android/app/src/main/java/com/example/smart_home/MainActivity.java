package com.example.smart_home;

import android.content.Intent;
import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  private String savedNote;

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

    Intent intent = getIntent();
    String action = intent.getAction();
    String type = intent.getType();
    
    savedNote = intent.getStringExtra(Intent.EXTRA_TEXT);

    new MethodChannel(getFlutterView(), "app.channel.shared.data")
      .setMethodCallHandler(new MethodChannel.MethodCallHandler() {
          @Override
          public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
            if (methodCall.method.contentEquals("getSavedNote")) {
              result.success(savedNote);
              savedNote = null;
            }
          }
      });
  }
}
