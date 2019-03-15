package com.example.hangman

import android.content.res.Configuration
import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.view.WindowManager
import android.widget.ImageView
import android.widget.Toast
import kotlinx.android.synthetic.main.activity_new.*

class NewActivity : AppCompatActivity() {

    private lateinit var iv: ImageView
    private lateinit var haslo: CharArray
    private  var myword=""
    private  var haslog=""
    private var mistake =0
    private var case= true


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        try {
            this.supportActionBar!!.hide()
        } catch (e: NullPointerException) {
        }

        setContentView(R.layout.activity_new)
        if (resources.configuration.orientation == Configuration.ORIENTATION_LANDSCAPE) {
            window.addFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN)

        } else {
            window.clearFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN)
        }
        game()
        btn1.setOnClickListener {
            if (editText.text.isEmpty()) {
                Toast.makeText(this, "Podaj literkę", Toast.LENGTH_SHORT).show()
            } else {
                val a = editText.text[0]
                if(textView4.text.contains(a,case)){
                    Toast.makeText(this, "Już podałeś tą literkę", Toast.LENGTH_SHORT).show()
                    return@setOnClickListener
                }

                var count = 0
                var haslohide=""
                for (i in 0.. haslo.size-1) {
                    if (haslo[i].equals(a,case)) {
                        haslohide = haslohide.plus(a.toString())
                        Toast.makeText(this, "Dobrze jest $a", Toast.LENGTH_SHORT).show()
                        count++
                    }else {
                        haslohide=haslohide.plus("*")
                    }
                }
                var temp =""
                for (i in 0 .. haslog.length -1){
                    if(haslog[i]!='*'){
                        temp= temp.plus(haslog[i])
                    }
                    else if(haslohide[i]!='*'){
                        temp= temp.plus(haslohide[i])
                    }
                    else temp = temp.plus("*")
                }
                haslog=temp
                show()
                if(!haslog.contains('*')){
                    Toast.makeText(this, "Wygrałeś", Toast.LENGTH_SHORT).show()

                }
                if(count==0){
                    hang()
                    var temp1 =  a.toString().plus(" ").plus(textView4.text)
                    textView4.text = temp1
                    mistake++
                }
            }
        }
        btn2.setOnClickListener {
            if(haslog.contains('*')){
                Toast.makeText(this, "Dokończ to hasło", Toast.LENGTH_SHORT).show()
            } else
            restart()
        }
    }
    fun restart(){
        btn1.isClickable=true
        mistake=0
        img.setImageResource(R.drawable.ic_launcher)
        haslog=""
        textView3.text=""
        textView4.text=""
        game()

    }
    fun hang(){
        if(mistake==0) img.setImageResource(R.drawable.a0)
        else if(mistake==1) img.setImageResource(R.drawable.a1)
        else if(mistake==2) img.setImageResource(R.drawable.a2)
        else if(mistake==3) img.setImageResource(R.drawable.a3)
        else if(mistake==4) img.setImageResource(R.drawable.a4)
        else if(mistake==5) img.setImageResource(R.drawable.a5)
        else if(mistake==6) {
            img.setImageResource(R.drawable.a6)
            Toast.makeText(this, "Przegrałeś ", Toast.LENGTH_SHORT).show()
            textView3.text = haslo.toString()
            btn1.isClickable=false
        }

    }
    fun show() {
        textView3.text = haslog.toString()
    }

    fun game() {
        val word: Array<String> = resources.getStringArray(R.array.words)
        myword=word.random()
        haslo =myword.toCharArray()
        haslo.forEach {
            haslog = haslog.plus("*")
        }
        textView3.text = haslog
    }

}




