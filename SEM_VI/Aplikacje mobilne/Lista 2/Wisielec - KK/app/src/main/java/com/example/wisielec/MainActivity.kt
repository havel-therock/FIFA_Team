package com.example.wisielec

import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import android.widget.EditText
import android.widget.ImageView
import android.widget.TextView
import java.util.*

class MainActivity : AppCompatActivity() {

    var gameEnd = false
    var wisielec = arrayOf<Int>()
    var pass = ""
    var guess: Array<Char> = arrayOf()
    var random = Random()
    var counter: Int = 0


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        preGame()
        startGame()
    }

    private fun preGame(){
        wisielec = arrayOf(
            R.drawable.wisielec0,
            R.drawable.wisielec1,
            R.drawable.wisielec2,
            R.drawable.wisielec3,
            R.drawable.wisielec4,
            R.drawable.wisielec5,
            R.drawable.wisielec6,
            R.drawable.wisielec7,
            R.drawable.wisielec8,
            R.drawable.wisielec9,
            R.drawable.wisielec10,
            R.drawable.wisielec11,
            R.drawable.wisielec12)
    }

    private fun startGame(){
        gameEnd = false
        counter = 0
        var fortuneWheel = resources.getStringArray(R.array.slownik)
        var rand: Int = random.nextInt(10)
        pass = fortuneWheel[rand]

        guess = arrayOf()
        for(i in 0..pass.length-1) {
            guess += '_'
        }

        var bttn = findViewById<Button>(R.id.button)
        bttn.setText("confirm")
        bttn.setOnClickListener {
                checkLetter(findViewById<EditText>(R.id.editText).text[0])
        }

        findViewById<ImageView>(R.id.imageView).setImageResource(wisielec[0])
        findViewById<TextView>(R.id.textView).setText(formatPassword(guess))
    }

    private fun endGame(won: Boolean){
        if(won){
            findViewById<ImageView>(R.id.imageView).setImageResource(wisielec[12])
        }
        var bttn = findViewById<Button>(R.id.button)
        bttn.setText("restart")
        bttn.setOnClickListener {
            startGame()
        }
    }

    private fun checkLetter(letter: Char){
        var used = false
        var won: Boolean
        for(i in 0..pass.length-1){
            if(pass[i] == letter) {
                guess[i] = pass[i]
                used = true
            }
        }
        if(!used){
            if(counter == 10)
                endGame(false)
            counter++
            findViewById<ImageView>(R.id.imageView).setImageResource(wisielec[counter])
        }else {
            findViewById<TextView>(R.id.textView).setText(formatPassword(guess))
            won = true
            for(i in 0..pass.length-1){
                if(pass[i]!=guess[i]) {
                    won = false
                    break
                }
            }
            if(won)
                endGame(true)
        }
    }

    private fun formatPassword(password: Array<Char>): String{
        var formattedGuess: Array<Char> = arrayOf()
        for(i in 0..password.size*2) {
            formattedGuess += ' '
        }

        for(i in 0..password.size-1){
            formattedGuess.set(i*2,password[i])
        }
        return String(formattedGuess.toCharArray())
    }
}
