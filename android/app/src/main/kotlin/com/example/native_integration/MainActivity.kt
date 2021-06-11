package com.example.native_integration

import android.opengl.Visibility
import android.os.Bundle
import android.os.PersistableBundle
import android.view.View
import android.widget.ImageView
import com.yhao.floatwindow.FloatWindow
import com.yhao.floatwindow.Screen
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private   val CHANNEL : String   = "floating_button"
    private lateinit var channel : MethodChannel;

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
        channel.setMethodCallHandler { call, _ -> run {
            var imageView = ImageView(applicationContext)
            imageView.setImageResource(R.drawable.plus)
            when(call.method){
                "create"->createFloating(imageView)
                "hide"->FloatWindow.get().hide()
                "show"-> FloatWindow.get().show()

            }
        } }
    }

    override fun onDestroy() {
        FloatWindow.destroy()
        super.onDestroy()
    }

    fun createFloating(imageView: ImageView){

       FloatWindow
                .with(applicationContext)
                .setView(imageView)
                .setWidth(100)                               //设置控件宽高
                .setHeight(Screen.width,0.2f)
                .setX(100)                                   //设置控件初始位置
                .setY(Screen.height,0.3f)
                .setDesktopShow(true)
                .build()
        FloatWindow.get().show()

        imageView.setOnClickListener {
this.channel.invokeMethod("increment",null);

        }
    }
}
