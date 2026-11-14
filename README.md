![Robot finds kitten heading](<assets/image-l2Tr3S.png>)


# What Is This Thing - Anyway?

**Robot Finds Kitten** is a Zen Simulation (according to the original author) - which means you can play without worry of losing.  The original concept and implementation is credited to Leonard Richardson who wrote the game to play on an MS/DOS PC in 1997.

There are many, many implemtations of the program on multiple platforms and in multiple languages.  Point your webbrowser over to [https://robotfindskitten.org/](https://robotfindskitten.org/) to learn more about the original game.  Also, Wikipedia has a short page about the program as well here: [https://en.wikipedia.org/wiki/Robotfindskitten](https://en.wikipedia.org/wiki/Robotfindskitten).

I am an old school BASIC programmer amoung other things and I thought I knew most of the old school text games that had any kind of popularity.  You know the kind: Hunt the wumpus, SuperTrek, Hammurabi and Lunar Lander.  I was really suprised when I came across **Robot Finds Kitten** a few weeks ago, never having heard of it before.

A little research proved that it had a pretty wide following.  There are at least two dozen implementations listed in GitHub.  I knew I had to take a crack at it.  I could have vibe coded one in Python in about five minutes, but what fun is that.  I wanted to experience the challenge of writing my own.  So I brushed the dust off of my **Liberty BASIC** installation and went to work.

This is coded in Liberty BASIC 4.5.1, but it should run just fine in Just BASIC 2.x (which is the free version of the same programming language with a few whistles and bells removed).  Get your own copy of the development platform here: [https://www.libertybasic.com/](https://www.libertybasic.com/) - or you can get Lust BASIC here: [https://www.justbasic.com/](https://www.justbasic.com/)

## Download the Game

Download the game from the GitHub repository Releases or use this [LINK](https://github.com/bjazmoore/LB-Robot-Finds-Kitten/releases/tag/v.1)

## How to Run the Game

The game has been compiled into a tokenized file and linked to an executable to make it easy to run on your computer even if you do not own Liberty BASIC.  After you download the ZIP file from the repository follow these steps to run the program:

1. Fine the ZIP file and extract the contents
2. Open the folder that is created
3. Double click the RobotFindsKitten.exe file

![Launching the game](<assets/launch.png>)

ENJOY!

## How To Play

Game play takes place on a grid of 36 x 58 cells.  Thirty two items are displayed on the playing board as shown in the image below:

![rfk](<assets/image-nNe8v4.png>)



You are a robot who is searching the play area for a lost kitten.  The robot begins in the middle of the play area.  It is represented by a white "#" (Hash symbol):

![rfk-robot](<assets/image-ARcEmA.png>)



Thirty one other items are randomly spread around the board.  One of these is the lost kitten.  The kitten will always assume the shape of  different item each time the game is played.  The kitten is randomly placed on the board each time the game is played.  Your goal as the player is to find the kitten.

Move the robot around play area using the "W", "A", "S", and "D" keys to move around:

![wasd](<assets/image-xS2s3o.jpg>)


`(https://www.vecteezy.com/free-vector/wasd-keys" Wasd Keys Vectors by Vecteezy)`

- W = move up
- A = move left
- S = move down
- D = move right
  

![rfk-movement](<assets/image-zLGjYS.png>)



Move the robot around the board and interrogate each item as to its identity.  Interrogation is done by pressing against the item from any of the sides.  The identity of the item will be show in the message area at the bottom of the game play area:

![rfk-item](<assets/image-jhff0t.png>)



In the example above the robot is navigated to the item "R" using the "A" key.  Once robot is next to the item (The "R" in this example) press the "A" key to press the robot "#"  against the item to interrogate the item.

Each time an item is interrogated it will reveal its identity.  Your goal here is to find the kitten by checking to see what each item really is.

## Quitting the Game

Close the application by clicking the close "X" in the upper right corner.

![rfk-close](<assets/image-qnOqT2.png>)



**Have Fun and go find that kitten!**


---

## About the Program

- Name: RFK.BAS
- Author: Brad Moore
- Written: November 2026
- AI Use: None
- Language: BASIC (Liberty BASIC)
- License: GPL3
