package com.autinmitra.secondlab

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.compose.foundation.ScrollableColumn
import androidx.compose.foundation.Text
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.layout.RowScope.gravity
import androidx.compose.material.*
import androidx.compose.runtime.Composable
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.focus.ExperimentalFocus
import androidx.compose.ui.focus.FocusState
import androidx.compose.ui.focusObserver
import androidx.compose.ui.platform.setContent
import androidx.compose.ui.res.stringArrayResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.ui.tooling.preview.Preview
import com.autinmitra.secondlab.ui.SecondLabTheme
import com.autinmitra.secondlab.ui.ThemeState

class MainActivity : AppCompatActivity() {
    @ExperimentalFocus
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            SecondLabTheme {
                // A surface container using the 'background' color from the theme
                Surface(color = MaterialTheme.colors.background) {
                    Content()
                }
            }
        }
    }
}

@ExperimentalFocus
@Composable
fun Content() {
    Scaffold(
        modifier = Modifier.padding(24.dp),
        bodyContent = { ContentColumn() },
    )

}


@ExperimentalFocus
@Composable
fun ContentColumn() {
    val quotes = stringArrayResource(R.array.inspir_quote)
    val helloTitle = stringResource(R.string.hello_title)
    val quoteOfTheDay = stringResource(R.string.quote_of_the_day)
    val enterNameField = stringResource(R.string.enter_name_field)
    val myNameButton = stringResource(R.string.my_name_button)
    val quoteButton = stringResource(R.string.quote_button)
    val themeButton = stringResource(R.string.theme_button)

    val typography = MaterialTheme.typography
    val text = remember { mutableStateOf("") }
    val name = remember { mutableStateOf("") }
    val quote = remember { mutableStateOf("") }
    val focused = remember { mutableStateOf(false) }

    val theme = if (ThemeState.isLight.value) "Light" else "Dark"

    fun onTextUpdate(value: String) {
        text.value = value
    }

    fun onNameButtonClick() {
        name.value = text.value
    }

    fun onQuoteButtonClick() {
        quote.value = quotes.random()
    }

    fun onThemeButtonClick() {
        ThemeState.isLight.value = !ThemeState.isLight.value
    }

    ScrollableColumn(
        verticalArrangement = Arrangement.Center,
        modifier = if (!focused.value) Modifier.fillMaxSize() else Modifier.fillMaxWidth()
    ) {
        Text(
            text = "$helloTitle ${name.value}",
            style = typography.h3.copy(fontWeight = FontWeight.ExtraBold),
        )
        if (quote.value.isNotEmpty())
            Text(
                text = "$quoteOfTheDay: ${quote.value}",
                style = TextStyle(fontWeight = FontWeight.SemiBold),
            )
        Spacer(Modifier.preferredHeight(12.dp))
        OutlinedTextField(
            modifier = Modifier.fillMaxWidth().focusObserver { focusState ->
                focused.value = focusState == FocusState.Active
            },
            value = text.value,
            onValueChange = { onTextUpdate(it) },
            label = { Text(enterNameField) }
        )
        Spacer(Modifier.preferredHeight(18.dp))
        Button(onClick = { onNameButtonClick() }) {
            Text(text = myNameButton)
        }
        Spacer(Modifier.preferredHeight(12.dp))
        Button(onClick = { onQuoteButtonClick() }) {
            Text(text = quoteButton)
        }
        Spacer(Modifier.preferredHeight(12.dp))
        Button(onClick = { onThemeButtonClick() }) {
            Text(text = "$themeButton: $theme")
        }
    }
}

@ExperimentalFocus
@Preview(showBackground = true)
@Composable
fun DefaultPreview() {
    SecondLabTheme {
        Content()
    }
}