package com.example.data_store_example

import android.content.Context
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity(), SensorEventListener, EventChannel.StreamHandler {
    private val channelName = "com.auguryapps.toast"
    private val eventChannel = "com.auguryapps.magnet"
    
    private lateinit var sensorManager: SensorManager
    private var magneticSensor: Sensor? = null
    private var eventSink: EventChannel.EventSink? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Event Channel functions
        sensorManager = getSystemService(Context.SENSOR_SERVICE) as SensorManager
        magneticSensor = sensorManager.getDefaultSensor(Sensor.TYPE_MAGNETIC_FIELD)
        val event = EventChannel(flutterEngine.dartExecutor.binaryMessenger, eventChannel)
        event.setStreamHandler(this)

        // Method Channel functions

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            channelName
        ).setMethodCallHandler { call, result ->
            var msg: String? = ""
            if (call.method == "showToast") {
                msg = call.argument<String>("message")
                showToast(message = msg!!)
                result.success(true)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun showToast(message: String) {
        Toast.makeText(this, message, Toast.LENGTH_LONG).show()
    }

    override fun onSensorChanged(event: SensorEvent?) {
        if (event!!.sensor.type == Sensor.TYPE_MAGNETIC_FIELD) {
            val values = listOf(event.values[0], event.values[1], event.values[2])
            eventSink!!.success(values)
        }
    }

    override fun onAccuracyChanged(sensor: Sensor?, accuracy: Int) {

    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        eventSink = events
        registerSensor()
    }

    override fun onCancel(arguments: Any?) {
        unRegisterSensor()
        eventSink = null
    }

    //Register SensorManger
    private fun registerSensor() {
        if (eventSink == null) return
        magneticSensor = sensorManager!!.getDefaultSensor(Sensor.TYPE_MAGNETIC_FIELD)
        sensorManager.registerListener(this, magneticSensor, SensorManager.SENSOR_DELAY_UI)

    }    //UnregisterSensor

    private fun unRegisterSensor() {
        if (eventSink == null) return
        sensorManager.unregisterListener(this)
    }
}
