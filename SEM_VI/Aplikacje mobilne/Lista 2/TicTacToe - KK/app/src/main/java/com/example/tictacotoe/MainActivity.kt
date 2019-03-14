package com.example.tictacotoe

import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import android.widget.ImageButton

class MainActivity : AppCompatActivity() {

    var player: Boolean = true
    var gameEnd: Boolean = false
    var won: Boolean = true
    var cntr: Int = 0
    var helpTable = arrayOf<Array<Int>>()
    var buttonIDs: Array<ImageButton> = arrayOf()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        buttonIDs = arrayOf(
            findViewById<ImageButton>(R.id.imageButton1),
            findViewById<ImageButton>(R.id.imageButton2),
            findViewById<ImageButton>(R.id.imageButton3),
            findViewById<ImageButton>(R.id.imageButton4),
            findViewById<ImageButton>(R.id.imageButton5),
            findViewById<ImageButton>(R.id.imageButton6),
            findViewById<ImageButton>(R.id.imageButton7),
            findViewById<ImageButton>(R.id.imageButton8),
            findViewById<ImageButton>(R.id.imageButton9),
            findViewById<ImageButton>(R.id.imageButton10),
            findViewById<ImageButton>(R.id.imageButton11),
            findViewById<ImageButton>(R.id.imageButton12),
            findViewById<ImageButton>(R.id.imageButton13),
            findViewById<ImageButton>(R.id.imageButton14),
            findViewById<ImageButton>(R.id.imageButton15),
            findViewById<ImageButton>(R.id.imageButton16),
            findViewById<ImageButton>(R.id.imageButton17),
            findViewById<ImageButton>(R.id.imageButton18),
            findViewById<ImageButton>(R.id.imageButton19),
            findViewById<ImageButton>(R.id.imageButton20),
            findViewById<ImageButton>(R.id.imageButton21),
            findViewById<ImageButton>(R.id.imageButton22),
            findViewById<ImageButton>(R.id.imageButton23),
            findViewById<ImageButton>(R.id.imageButton24),
            findViewById<ImageButton>(R.id.imageButton25)
        )
        boardSetup()
        startGame()
    }

    private fun boardSetup() {
        for(i in 0..4) {
            var array = arrayOf<Int>()
            for(j in 0..4) {
                array += 0
            }
            helpTable += array
        }
    }

    private fun buttonClicked(btn: ImageButton) {
        if(player)
            btn.setImageResource(R.drawable.crossfire)
        else
            btn.setImageResource(R.drawable.circleocean)
        logicCheck()
        player = !player
        btn.setOnClickListener {}
    }

    private fun logicCheck(){
        mainFor@for(i in 0..4){
            for(j in 0..3){
                if(helpTable[i][j] != helpTable[i][j+1] || helpTable[i][j] == 0)
                    continue@mainFor
            }
            gameEnd = true
            won = player
        }

        mainFor@for(i in 0..4){
            for(j in 0..3){
                if(helpTable[j][i] != helpTable[j+1][i] || helpTable[j][i] == 0)
                    continue@mainFor
            }
            gameEnd = true
            won = player
        }

        var temp = true
        for(i in 0..3){
            if(helpTable[i][i] != helpTable[i+1][i+1] || helpTable[i][i] == 0)
                temp = false
        }
        if(temp){
            gameEnd = true
            won = player
        }

        temp = true
        for(i in 0..3){
            if(helpTable[i][4-i] != helpTable[i+1][3-i] || helpTable[i][4-i] == 0)
                temp = false
        }
        if(temp){
            gameEnd = true
            won = player
        }

        if(cntr == 25) {
            findViewById<Button>(R.id.textView).isClickable = true
            findViewById<Button>(R.id.textView).setText("It's a draw")
        }
        else if(gameEnd) {
            findViewById<Button>(R.id.textView).isClickable = true
            endGame()
            if (won)
                findViewById<Button>(R.id.textView).setText("You won!")
            else
                findViewById<Button>(R.id.textView).setText("You lost!")
        }
    }

    private fun endGame(){
        for(i in 0..24){
            buttonIDs[i].isClickable = false
        }
    }

    private fun startGame(){
        gameEnd = false
        cntr = 0
        findViewById<Button>(R.id.textView).setText("Game in progress")
        findViewById<Button>(R.id.textView).setOnClickListener {
            startGame()
        }
        findViewById<Button>(R.id.textView).isClickable = false
        for(i in 0..24){
            buttonIDs[i].setImageResource(R.drawable.blank)
            buttonIDs[i].isClickable = true
        }

        for(i in 0..24) {
            buttonIDs[i].setOnClickListener {
                cntr++
                if(player)
                    helpTable[i/5][i%5] = 1
                else
                    helpTable[i/5][i%5] = 2
                buttonClicked(buttonIDs[i])
            }
        }

        for(i in 0..4) {
            for(j in 0..4) {
                helpTable[i][j] = 0
            }
        }
    }
}
