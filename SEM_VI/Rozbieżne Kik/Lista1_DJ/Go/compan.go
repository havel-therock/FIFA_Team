package main

import (
	"bufio"
	"os"

	//"container/list"
	"fmt"
	"math/rand"
	"time"
)

var taskBoard []Task
var magazine [] int

type Task struct {
	FirstArgument  int
	SecondArgument int
	Operator       string
}

func produce() Task {
	rand.Seed(time.Now().UnixNano())
	var r1 string
	r2 := rand.Intn(3)
	if r2 == 0 {
		r1 = "+"
	} else if r2 == 1 {
		r1 = "-"
	} else {
		r1 = "*"
	}
	return Task{rand.Intn(100), rand.Intn(100), r1}
}
func president() {
	for {
		if len(taskBoard) < maxBoard {
			var x = produce()
			taskBoard = append(taskBoard, x)
			if Talkative {
				fmt.Println("Made task ", x)
			}
		}
		r := rand.Intn(presidentDelay) + 10000
		time.Sleep(time.Duration(r) * time.Microsecond)
	}
}
func work(x int, y int, s string) int {
	if s == "+" {
		return x + y
	} else if s == "-" {
		return x - y
	} else {
		return x * y
	}
}
func worker(i int) {

	for {
		if len(taskBoard) > 0 && len(magazine) < maxMagazine {
			var e = taskBoard[0]
			if Talkative {
				fmt.Print("Worker ", i, " working on ", e.FirstArgument, " ")
				fmt.Print(e.Operator, " ")
				fmt.Print(e.SecondArgument, " = ")
				fmt.Println(work(e.FirstArgument, e.SecondArgument, e.Operator))
			}
			magazine = append(magazine, work(e.FirstArgument, e.SecondArgument, e.Operator))
			taskBoard = taskBoard[1:]
		}
		r := rand.Intn(workerDelay) + 10000
		time.Sleep(time.Duration(r) * time.Microsecond)
	}
}
func buyer() {
	for {
		if len(magazine) > 0 && Talkative {
			var e = magazine[0]
			fmt.Println("\n Buy  ", e)
			magazine = magazine[1:]
		}
		r := rand.Intn(buyerDelay) + 10000
		time.Sleep(time.Duration(r) * time.Microsecond)
	}
}
func scanner() {
	scanner := bufio.NewScanner(os.Stdin)
	fmt.Printf("Available options: \n -Show Board\n -Show Magazine \n")
	for scanner.Scan() {
		if scanner.Text() == "show board" {
			for i, v := range taskBoard {
				fmt.Printf("Available task nr %d is %v \n", i, v)
			}
		} else if scanner.Text() == "show magazine" {
			for i, v := range magazine {
				fmt.Printf("Available product nr %d is %d \n", i, v)
			}
		} else {
			fmt.Println("Incorrect option.")
		}
	}
}
func main() {
	go president()
	for i := 1; i < workers+1; i++ {
		go worker(i)
	}
	go buyer()
	if !Talkative {
		scanner()
	}
	for {
		time.Sleep(100 * time.Millisecond)
	}

}
