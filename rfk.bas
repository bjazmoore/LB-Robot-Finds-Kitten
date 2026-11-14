
    global true, false, gameover  
    true = 1
    false = 0
    gameover = false

    UpperLeftX = 60
    UpperLeftY = 90
    WindowWidth = 947   '58 cells
    WindowHeight = 654  '36 cells

    'set the board size
    cellsx = 58
    cellsy = 36

    messageDisplayed = 0 'if no message - set to zero.  Id message set to the message index number

    symbolCnt = 80
    dim board(cellsy, cellsx)  '1-30 = items that might be kitten, 31 = kitten, 32 = robot
    dim messages$(400)
    dim location(2)
    dim symbol$(symbolCnt) 'the actual symbols - one per element, each unique
    dim colors$(10)

    color$(1) = "yellow"
    color$(2) = "green"
    color$(3) = "red"
    color$(4) = "cyan"
    color$(5) = "pink"

    'load the ending game image
    loadbmp "rfk", "rfk.bmp"
    

    'build the symbols string array
    for x = 1 to symbolCnt
        read value
        symbol$(x) = chr$(value)
    next x
    'shuffle the symbol array
    for x = 1 to 260
        s1 = rndValue(1,symbolCnt)
        s2 = rndValue(1,symbolCnt)
        if s1 <> s2 then
            temp$ = symbol$(s1)
            symbol$(s1) = symbol$(s2)
            symbol$(s2) = temp$
        end if
    next x

    
    'read all the messages from the message file into the array
    open "rfk-messages.txt" for input as #m
    cnt = 1
    while eof(#m) = 0
        line input #m, text$
        messages$(cnt) = text$
        cnt = cnt + 1
    wend
    close #m
    msgCnt = cnt - 1

    'shuffle the messages array
    for x = 1 to 900
        s1 = rndValue(1,msgCnt)
        s2 = rndValue(1,msgCnt)
        if s1 <> s2 then
            temp$ = messages$(s1)
            messages$(s1) = messages$(s2)
            messages$(s2) = temp$
        end if
    next x


    'build the board out
    'place robot first
    robotx = 29
    roboty = 18
    board(roboty,robotx) = 32

    'find a place for kitten
    result = findFreeLocation()
    board(location(1),location(2)) = 31
    print "Kitten is at: ";location(1);", ";location(2)
    print "Kitten is a: ";symbol$(31)


    'add other 40 items to the board
    for x = 1 to 30
        result = findFreeLocation()
        board(location(1),location(2)) = x 'set to zero for now, change to x when ready
    next x


' -----------------------------------------------------
'   Open the window for graphics

    'nomainwin
    open "Robot finds kitten" for graphics_nsb_nf as #g
    #g, "home ; down"
    #g, "fill black"
    #g, "color white"
    #g, "backcolor black"
    #g, "when characterInput [fetch]"
    #g, "when leftButtonDown report"
    #g, "setfocus"
    #g, "trapclose [quit]"

    call drawboard robotx, roboty, messageDisplayed
    wait


[fetch]
    key$ = Inkey$
    if len(key$) > 0 then
        'we have some input
        blockedx = false
        blockedy = false
        robotxold = robotx
        robotyold = roboty
        messageDisplayed = 0

        if upper$(key$) = "W" then
            roboty = roboty - 1
            if roboty < 1 then roboty = 1
            messageDisplayed = checkRobotMove(roboty, robotx)
        end if

        if upper$(key$) = "S" then
            roboty = roboty + 1
            if roboty > cellsy then roboty = cellsy
            messageDisplayed = checkRobotMove(roboty, robotx)
        end if

        if upper$(key$) = "A" then
            robotx = robotx - 1
            if robotx < 1 then robotx = 1
            messageDisplayed = checkRobotMove(roboty, robotx)
        end if

        if upper$(key$) = "D" then
            robotx = robotx + 1
            if robotx > cellsx then robotx = cellsx
            messageDisplayed = checkRobotMove(roboty, robotx)
        end if

        'see if there is a message to display (if so we reset robotx and roboty and draw the board)
        if messageDisplayed > 0 then
            robotx = robotxold
            roboty = robotyold
            call drawboard robotx, roboty, messageDisplayed
        end if

        'see if the robot location changed
        if robotx <> robotxold or roboty <> robotyold then
            'print "robot has moved"
            call drawboard robotx, roboty, messageDisplayed
        end if
    end if
    wait


    sub report handle$, x, y
        print "Mouse pointer at: ";x; ", "; y
        'see if the user clicked the help area
        if x > 875 and x < 933 and y > 582 and y < 613 then
            print "You have clicked the Help button"
        end if 
    end sub

    sub drawboard robotx, roboty, messageDisplayed
        if gameover = false then
            'begin by drawing a large black filled rectangle
            #g, "discard"
            #g, "up; goto 0 0; down"
            #g, "color black"
            #g, "boxfilled ";WindowWidth;" ";WindowHeight
            

            'draw the help button
            #g, "color white"
            #g, "up; goto 875 582; down; box 933 614"
            #g, "up; goto 887 605; down"
            #g, "font arial 12 bold"
            #g, "\Help"

            'draw the message box
            #g, "up; goto 3 582; down; box 933 614"

            'print an item message (8, 590)
            #g, "up; goto 9 605; down"
            #g, "font arial 12"
            #g, "\";messages$(messageDisplayed)


            'draw the items on the board
            #g, "font arial 14 bold"
            for x = 1 to 36
                for y = 1 to 58
                    'if the board location is zero or 32 (the robot) then ignore
                    if board(x,y) > 0 and board(x,y) < 32 then
                        'set the pen location
                        locx = calcLocation(x) + 14
                        locy = calcLocation(y) - 1
                        'print "Moving pen to :";locy;", ";locx;" - printing: ";symbol$(board(x,y))
                        c = (board(x,y) mod 5) + 1
                        #g, "color ";color$(c)
                        #g, "up; goto ";locy;" ";locx;"; down"
                        #g, "\";symbol$(board(x,y))
                    end if
                next y
            next x
            #g, "color white"

            'draw the robot in the new location
            print "New robot location: rby - ";roboty;", rbx - ";robotx
            locx = calcLocation(robotx) '+ 15
            locy = calcLocation(roboty) + 15
            #g, "up; color white; goto ";locx;" ";locy;"down"
            #g, "\#"
        end if

    end sub


    sub youfoundkitten
        'you found the kitten
        #g, "drawbmp rfk -20 0"
        gameover = true


    end sub


[quit]
    close #g       
    
    

' ********************************************************************************
'  H e l p e r   F u n c t i o n s
' ********************************************************************************

    function checkRobotMove(ry, rx)
        'return a message number if successful - if not return zero 
        msg = 0
        print "At robot location: ";symbol$(board(ry, rx))
        'if it kitten we need to do something else
        if board(ry, rx) = 31 then 'that is kitten
            print "You found kitten!"
            call youfoundkitten
        else
            msg = board(ry, rx)
        end if
        checkRobotMove = msg
    end function

    function findFreeLocation()
        success = false
        while success = false
            x = rndValue(2,35)
            y = rndValue(2,57)
            if board(x,y) = 0 then
                'next see if the cells around it are clear
                success = true
                for j = x-1 to x+1
                    if board(j,y-1) <> 0 then success = false
                    if board(j,y+1) <> 0 then success = false
                next j
                if board(x-1,y) <> 0 then success = false
                if board(x+1,y) <> 0 then success = false
                if success = true then
                    location(1) = x
                    location(2) = y
                end if
            end if
        wend
        findFreeLocation = 1
    end function

    function rndValue(lower,upper)
        'returns a random number between lower and upper (inclusive)
        if upper < lower or upper = lower then
            rndValue = -1
            exit function
        end if
        rndValue = int(rnd(1)*(upper-lower)) + 1 + lower
    end function

    function calcLocation(loc)
        'calculate the graphic location of a grid location
        calcLocation = loc * 16 - 15
    end function


'symbol data - 80 symbols
data 33, 34, 36, 37, 38, 42, 43, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 60
data 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79
data 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 94, 128, 131, 134, 135, 139, 140
data 153, 162, 163, 164, 165, 167, 169, 171, 177, 181, 182, 187, 188, 189
data 190, 198, 208, 216, 222, 223, 228, 230, 232, 241, 247, 999