package com.autinmitra.thirdlab

import android.content.Context
import android.content.SharedPreferences
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.view.View
import android.widget.Button
import android.widget.SeekBar
import android.widget.SeekBar.OnSeekBarChangeListener

class MainActivity : AppCompatActivity() {
    private lateinit var pref: SharedPreferences

    private lateinit var seekBar: SeekBar
    private lateinit var buttonTR: Button
    private lateinit var buttonTL: Button
    private lateinit var buttonBR: Button
    private lateinit var buttonBL: Button

    private var buttonTRValue = 0
    private var buttonTLValue = 0
    private var buttonBRValue = 0
    private var buttonBLValue = 0
    private var seekBarProgress = 0

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        pref = getSharedPreferences("Button", Context.MODE_PRIVATE)

        seekBar = findViewById(R.id.seekBar)
        buttonTR = findViewById(R.id.btntr)
        buttonTL = findViewById(R.id.btntl)
        buttonBR = findViewById(R.id.btnbr)
        buttonBL = findViewById(R.id.btnbl)

        buttonTRValue = pref.getInt("tr", 0)
        buttonTLValue = pref.getInt("tl", 0)
        buttonBRValue = pref.getInt("br", 0)
        buttonBLValue = pref.getInt("bl", 0)

        seekBarProgress = pref.getInt("seekbarProgress", 0)
        seekBar.setProgress(seekBarProgress, true)

        updateState()

        seekBar.setOnSeekBarChangeListener(object: OnSeekBarChangeListener {
            override fun onProgressChanged(seekBar: SeekBar?, progress: Int, fromUser: Boolean) {
                seekBarProgress = progress
                updateState()
            }

            override fun onStartTrackingTouch(seekBar: SeekBar?) {
                Log.i("SeekBar","Started seekbar tracking")
            }

            override fun onStopTrackingTouch(seekBar: SeekBar?) {
                Log.i("SeekBar", "Stopped seekbar tracking")
            }
        })
    }

    override fun onPause() {
        super.onPause()
        val editor = pref.edit()
        editor.putInt("tr", buttonTRValue)
        editor.putInt("tl", buttonTLValue)
        editor.putInt("br", buttonBRValue)
        editor.putInt("bl", buttonBLValue)
        editor.putInt("seekbarProgress", seekBarProgress)
        editor.apply()
    }

    private fun updateState() {
        val textSize = (18+seekBar.progress/5).toFloat()
        buttonTR.text = buttonTRValue.toString()
        buttonTL.text = buttonTLValue.toString()
        buttonBR.text = buttonBRValue.toString()
        buttonBL.text = buttonBLValue.toString()
        buttonTR.textSize = textSize
        buttonTL.textSize = textSize
        buttonBR.textSize = textSize
        buttonBL.textSize = textSize
    }

    fun onButtonTRClick(view: View) {
        ++buttonTRValue
        updateState()
    }

    fun onButtonTLClick(view: View) {
        ++buttonTLValue
        updateState()
    }

    fun onButtonBRClick(view: View) {
        ++buttonBRValue
        updateState()
    }

    fun onButtonBLClick(view: View) {
        ++buttonBLValue
        updateState()
    }
}