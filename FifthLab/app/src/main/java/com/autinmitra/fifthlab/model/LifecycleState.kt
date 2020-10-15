package com.autinmitra.fifthlab.model

import androidx.compose.runtime.mutableStateOf
import androidx.lifecycle.ViewModel

class LifecycleState : ViewModel() {
    val onCreateCounter = mutableStateOf(0)
    val onStartCounter = mutableStateOf(0)
    val onResumeCounter = mutableStateOf(0)
    val onPauseCounter = mutableStateOf(0)
    val onStopCounter = mutableStateOf(0)
    val onRestartCounter = mutableStateOf(0)
    val onDestroyCounter = mutableStateOf(0)

    fun incrementOnCreateCounter() { ++onCreateCounter.value }
    fun incrementOnStartCounter() { ++onStartCounter.value }
    fun incrementOnResumeCounter () { ++onResumeCounter.value }
    fun incrementOnPauseCounter() { ++onPauseCounter.value }
    fun incrementOnStopCounter () { ++onStopCounter.value }
    fun incrementOnRestartCounter() { ++onRestartCounter.value }
    fun incrementOnDestroyCounter() { ++onDestroyCounter.value }

}


















