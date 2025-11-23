package com.example.lab1compose

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.Image
import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp

// Note: You might need to replace R.drawable.ic_launcher_foreground with your actual image resource.
// For this lab, ensure you have an image accessible or use a placeholder.

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            Lab1Layout()
        }
    }
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun Lab1Layout() {
    Scaffold(
        topBar = {
            TopAppBar(
                title = { Text("Example 2: Kotlin + Compose", color = Color.White) },
                colors = TopAppBarDefaults.topAppBarColors(containerColor = Color(0xFF009688))
            )
        }
    ) { innerPadding ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(innerPadding)
                .padding(16.dp),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            // Image
            // Using a system icon as placeholder if R.drawable is not set up in this raw file
            // In a real project, use: painter = painterResource(id = R.drawable.your_image)
            Box(
                modifier = Modifier
                    .size(150.dp)
                    .padding(top = 16.dp),
                contentAlignment = Alignment.Center
            ) {
                // Placeholder for the circular image
                 Text("IMAGE PLACEHOLDER")
            }

            Spacer(modifier = Modifier.height(32.dp))

            // Buttons Grid
            Row(
                horizontalArrangement = Arrangement.spacedBy(16.dp)
            ) {
                Button(onClick = { /* Do nothing */ }) {
                    Text("BUTTON")
                }
                Button(onClick = { /* Do nothing */ }) {
                    Text("BUTTON")
                }
            }
            
            Spacer(modifier = Modifier.height(16.dp))

            Row(
                horizontalArrangement = Arrangement.spacedBy(16.dp)
            ) {
                Button(onClick = { /* Do nothing */ }) {
                    Text("BUTTON")
                }
                Button(onClick = { /* Do nothing */ }) {
                    Text("BUTTON")
                }
            }

            Spacer(modifier = Modifier.height(64.dp))

            // Email Input
            var email by remember { mutableStateOf("") }
            Row(
                verticalAlignment = Alignment.CenterVertically,
                modifier = Modifier.fillMaxWidth()
            ) {
                Text(
                    text = "Email",
                    modifier = Modifier.width(60.dp)
                )
                TextField(
                    value = email,
                    onValueChange = { email = it },
                    modifier = Modifier.fillMaxWidth(),
                    singleLine = true
                )
            }
        }
    }
}

@Preview(showBackground = true)
@Composable
fun DefaultPreview() {
    Lab1Layout()
}
