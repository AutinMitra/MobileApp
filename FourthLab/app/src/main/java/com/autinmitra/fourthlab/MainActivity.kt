package com.autinmitra.fourthlab

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
    }

    fun goView2(view: View) { setContentView(R.layout.layout2) }

    fun goView3(view: View) { setContentView(R.layout.layout3) }

    fun goView4(view: View) { setContentView(R.layout.layout4) }

    fun goView5(view: View) { setContentView(R.layout.layout5) }


    fun goView6(view: View) { setContentView(R.layout.layout6) }


    fun goView7(view: View) { setContentView(R.layout.layout7) }

}