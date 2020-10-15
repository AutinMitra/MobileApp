package com.autinmitra.fifthlab

import android.content.Context
import android.content.SharedPreferences
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.compose.foundation.Box
import androidx.compose.foundation.ScrollableColumn
import androidx.compose.foundation.Text
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.*
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.setContent
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontFamily
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.ui.tooling.preview.Preview
import com.autinmitra.fifthlab.model.LifecycleState
import com.autinmitra.fifthlab.ui.*

class MainActivity : AppCompatActivity() {
    private val lifeCycleState = LifecycleState()
    private lateinit var sharedPrefs: SharedPreferences
    private var onCreateTotalValue = 0
    private var onStartTotalValue = 0
    private var onResumeTotalValue = 0
    private var onPauseTotalValue = 0
    private var  onStopTotalValue = 0
    private var onRestartTotalValue = 0
    private var onDestroyTotalValue = 0

    private var longTerm = true

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        sharedPrefs = getSharedPreferences("lifecycle", Context.MODE_PRIVATE)
        val editor = sharedPrefs.edit()
        editor.putInt("onCreateCounter", lifeCycleState.onCreateCounter.value)
        editor.apply()

        onCreateTotalValue = sharedPrefs.getInt("onCreateCounter", 0)
        lifeCycleState.onCreateCounter.value = onCreateTotalValue
        onStartTotalValue = sharedPrefs.getInt("onStartCounter", 0)
        lifeCycleState.onStartCounter.value = onStartTotalValue
        onResumeTotalValue = sharedPrefs.getInt("onResumeCounter", 0)
        lifeCycleState.onResumeCounter.value = onResumeTotalValue
        onPauseTotalValue = sharedPrefs.getInt("onPauseCounter", 0)
        lifeCycleState.onPauseCounter.value = onPauseTotalValue
        onStopTotalValue = sharedPrefs.getInt("onStopCounter", 0)
        lifeCycleState.onStopCounter.value = onStopTotalValue
        onRestartTotalValue = sharedPrefs.getInt("onRestartCounter", 0)
        lifeCycleState.onRestartCounter.value = onRestartTotalValue
        onDestroyTotalValue = sharedPrefs.getInt("onDestroyCounter", 0)
        lifeCycleState.onDestroyCounter.value = onDestroyTotalValue



        setContent {
            FifthLabTheme {
                // A surface container using the 'background' color from the theme
                Surface(color = MaterialTheme.colors.background) {
                    HomePage(lifeCycleState, toggleTimeSpan = {toggleTimeSpan()})
                }
            }
        }
        lifeCycleState.incrementOnCreateCounter()
    }

    override fun onStart() {
        super.onStart()
        lifeCycleState.incrementOnStartCounter()
        val editor = sharedPrefs.edit()
        editor.putInt("onStartCounter", lifeCycleState.onStartCounter.value)
        editor.apply()
    }

    override fun onResume() {
        super.onResume()
        lifeCycleState.incrementOnResumeCounter()
        val editor = sharedPrefs.edit()
        editor.putInt("onResumeCounter", lifeCycleState.onResumeCounter.value)
        editor.apply()
    }

    override fun onPause() {
        super.onPause()
        lifeCycleState.incrementOnPauseCounter()
        val editor = sharedPrefs.edit()
        editor.putInt("onPauseCounter", lifeCycleState.onPauseCounter.value)
        editor.apply()
    }

    override fun onStop() {
        super.onStop()
        lifeCycleState.incrementOnStopCounter()
        val editor = sharedPrefs.edit()
        editor.putInt("onStopCounter", lifeCycleState.onStopCounter.value)
        editor.apply()
    }

    override fun onRestart() {
        super.onRestart()
        lifeCycleState.incrementOnRestartCounter()
        val editor = sharedPrefs.edit()
        editor.putInt("onRestartCounter", lifeCycleState.onRestartCounter.value)
        editor.apply()
    }

    override fun onDestroy() {
        super.onDestroy()
        lifeCycleState.incrementOnDestroyCounter()
        val editor = sharedPrefs.edit()
        editor.putInt("onDestroyCounter", lifeCycleState.onDestroyCounter.value)
        editor.apply()
    }

    private fun toggleTimeSpan() {
        if (longTerm) {
            lifeCycleState.onCreateCounter.value -= onCreateTotalValue
            lifeCycleState.onStartCounter.value -= onStartTotalValue
            lifeCycleState.onResumeCounter.value -= onResumeTotalValue
            lifeCycleState.onPauseCounter.value -= onPauseTotalValue
            lifeCycleState.onStopCounter.value -= onStopTotalValue
            lifeCycleState.onRestartCounter.value -= onRestartTotalValue
            lifeCycleState.onDestroyCounter.value -= onDestroyTotalValue
        } else {
            lifeCycleState.onCreateCounter.value += onCreateTotalValue
            lifeCycleState.onStartCounter.value += onStartTotalValue
            lifeCycleState.onResumeCounter.value += onResumeTotalValue
            lifeCycleState.onPauseCounter.value += onPauseTotalValue
            lifeCycleState.onStopCounter.value += onStopTotalValue
            lifeCycleState.onRestartCounter.value += onRestartTotalValue
            lifeCycleState.onDestroyCounter.value += onDestroyTotalValue
        }
        longTerm = !longTerm
    }

}

@Composable
fun HomePage(lifeCycleState: LifecycleState, toggleTimeSpan: () -> Unit) {
    ScrollableColumn(Modifier.fillMaxSize()) {
        Button(
            modifier = Modifier.fillMaxWidth().padding(top=24.dp, start=24.dp, end=24.dp, bottom=12.dp),
            onClick = {toggleTimeSpan()},
            shape = RoundedCornerShape(12.dp)
        ) {
            Text("Toggle Timespan")
        }
        RunTimeCard(
            Modifier.fillMaxWidth().padding(horizontal = 24.dp, vertical = 12.dp),
            name = "onCreate",
            numTimes = lifeCycleState.onCreateCounter.value,
            backgroundColor = purple500
        )
        RunTimeCard(
            Modifier.fillMaxWidth().padding(horizontal = 24.dp, vertical = 12.dp),
            name = "onStart",
            numTimes = lifeCycleState.onStartCounter.value,
            backgroundColor = blue
        )
        RunTimeCard(
            Modifier.fillMaxWidth().padding(horizontal = 24.dp, vertical = 12.dp),
            name = "onResume",
            numTimes = lifeCycleState.onResumeCounter.value,
            backgroundColor = red
        )
        RunTimeCard(
            Modifier.fillMaxWidth().padding(horizontal = 24.dp, vertical = 12.dp),
            name = "onPause",
            numTimes = lifeCycleState.onPauseCounter.value,
            backgroundColor = green,
            textColor = Color.Black
        )
        RunTimeCard(
            Modifier.fillMaxWidth().padding(horizontal = 24.dp, vertical = 12.dp),
            name = "onStop",
            numTimes = lifeCycleState.onStopCounter.value,
            backgroundColor = purple,
            textColor = Color.Black
        )
        RunTimeCard(
            Modifier.fillMaxWidth().padding(horizontal = 24.dp, vertical = 12.dp),
            name = "onRestart",
            numTimes = lifeCycleState.onRestartCounter.value,
            backgroundColor = aquamarine,
            textColor = Color.Black
        )
        RunTimeCard(
            Modifier.fillMaxWidth().padding(top=12.dp, start=24.dp, end=24.dp, bottom=24.dp),
            name = "onDestroy",
            numTimes = lifeCycleState.onDestroyCounter.value,
            backgroundColor = redWood
        )
    }
}

@Composable
fun RunTimeCard(
    modifier: Modifier = Modifier,
    name: String,
    numTimes: Int,
    backgroundColor: Color,
    textColor: Color = Color.White
) {
    Card(
        modifier.fillMaxWidth(),
        shape = RoundedCornerShape(12.dp),
        backgroundColor = backgroundColor,
    ) {
        Column(Modifier.padding(all = 16.dp)) {
            Text("APP STATE", color = textColor, style = TextStyle(fontFamily = FontFamily.Monospace))
            Row(
                Modifier.fillMaxWidth(),
                verticalGravity = Alignment.CenterVertically,
                horizontalArrangement = Arrangement.SpaceBetween
            ) {
                Text(
                    name,
                    style = TextStyle(fontWeight = FontWeight.Bold, fontSize = 36.sp),
                    color = textColor
                )
                Box(
                    modifier = Modifier.preferredSize(48.dp),
                    shape = CircleShape,
                    backgroundColor = Color(0x70FFFFFF)
                ) {
                    Column(
                        modifier = Modifier.fillMaxSize()
                            .padding(top = 8.dp, bottom = 12.dp),
                        verticalArrangement = Arrangement.Center,
                        horizontalGravity = Alignment.CenterHorizontally
                    ) {
                        Text(
                            "$numTimes",
                            color = textColor,
                            style = TextStyle(fontWeight = FontWeight.Bold, fontSize = 24.sp),
                            textAlign = TextAlign.Center,
                        )
                    }
                }
            }
        }
    }
}

@Preview(showBackground = true)
@Composable
fun DefaultPreview() {
    FifthLabTheme {
        HomePage(LifecycleState(), {})
    }
}


