extends Node2D

#Gameplay Variables
var gameplayControl
var currentAnswer = ""
var sequence = ["Blind 45", "5", "6", "7", "15", "26"]
var rightWrongMarks = [0,0,0,0,0,0]		#controls wether mark on the plates at the end is a tick or a cross
var sequenceIterator = 0
var blindPlateTex = preload("res://ColorBlindTest/Sprites/Blind_Plate.png")
var fivePlateTex = preload("res://ColorBlindTest/Sprites/5_Plate.png")
var sixPlateTex = preload("res://ColorBlindTest/Sprites/6_Plate.png")
var sevenPlateTex = preload("res://ColorBlindTest/Sprites/7_Plate.png")
var fifteenPlateTex = preload("res://ColorBlindTest/Sprites/15_Plate.png")
var twentySixPlateTex = preload("res://ColorBlindTest/Sprites/26_Plate.png")
var rightTex = preload("res://ColorBlindTest/Sprites/Tick.png")
var wrongTex = preload("res://ColorBlindTest/Sprites/Cross.png")
var numPlate
var displayedNum
var displayedTimer
var inputUIGroup
var answered = false
export var maxTime: float = 15
var timer = maxTime
var endTest = false
#End Screen Variables
var endUI
var finalPlates
var verdict = 0
var highestVerdict = 0
#Main Menu Variables
var menuUI
var tutorialScreen

# Called when the node enters the scene tree for the first time.
func _ready():
	gameplayControl = get_node("Gameplay")
	gameplayControl.visible = false
	gameplayControl.set_process(false)
	inputUIGroup = get_node("Gameplay/InputUI")
	numPlate = get_node("Gameplay/Plate")
	displayedNum = get_node("Gameplay/InputUI/DisplayedNum")
	displayedTimer = get_node("Gameplay/Timer")
	endUI = get_node("EndUI")
	endUI.visible = false
	endUI.get_node("RestartButton").set_disabled(true)
	endUI.get_node("MenuReturn").set_disabled(true)
	menuUI = get_node("MainMenu")
	menuUI.visible = true
	tutorialScreen = get_node("TutorialScreen")
	tutorialScreen.visible = false
	finalPlates = get_node("EndUI/FinalPlates")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if gameplayControl.is_processing():
		#checks if the test has ended
		if sequenceIterator > 5 && !endTest:
			gameplayControl.visible = false
			gameplayControl.set_process(false)
			endTest = true
			ColorBlindData.isGameClear = true
			_end_screen_display()
			endUI.get_node("DisplayedVerdict").text = "Verdict: " + String(verdict) + "/6"
			for i in rightWrongMarks.size():
				if rightWrongMarks[i] == 1:
					finalPlates.get_child(i).get_node("RightWrong").set_texture(rightTex)
				else:
					finalPlates.get_child(i).get_node("RightWrong").set_texture(wrongTex)
			highestVerdict = max(highestVerdict, verdict)
			ColorBlindData.highestVerdict = highestVerdict
		#if the test is still ongoing after answering, change the number plate to display the current number in the sequence
		if answered == true && sequenceIterator < 6:
			answered = false
			match sequence[sequenceIterator]:
				"Blind 45":
					numPlate.set_texture(blindPlateTex)
				"5":
					numPlate.set_texture(fivePlateTex)
				"6":
					numPlate.set_texture(sixPlateTex)
				"7":
					numPlate.set_texture(sevenPlateTex)
				"15":
					numPlate.set_texture(fifteenPlateTex)
				"26":
					numPlate.set_texture(twentySixPlateTex)
		
		#controls the time during the test
		timer -= delta
		if timer <= 0 && sequenceIterator < 6:
			answered = true
			_check_answer()
			_next_in_sequence()
		displayedTimer.text =  String("%.2f" % timer)

#Changes the displayed number plate to the next in the sequence
func _next_in_sequence():
	currentAnswer = ""
	sequenceIterator += 1
	timer = maxTime

func _check_answer():
	match sequence[sequenceIterator]:
		"Blind 45":
			if(currentAnswer == ""):
				verdict += 1
				rightWrongMarks[0] = 1
		"5":
			if(currentAnswer == "5"):
				verdict += 1
				rightWrongMarks[1] = 1
		"6":
			if(currentAnswer == "6"):
				verdict += 1
				rightWrongMarks[2] = 1
		"7":
			if(currentAnswer == "7"):
				verdict += 1
				rightWrongMarks[3] = 1
		"15":
			if(currentAnswer == "15"):
				verdict += 1
				rightWrongMarks[4] = 1
		"26":
			if(currentAnswer == "26"):
				verdict += 1
				rightWrongMarks[5] = 1

func _main_menu_display():
	if !menuUI.visible:
		menuUI.get_node("StartButton").set_disabled(false)
		menuUI.get_node("HelpButton").set_disabled(false)
		menuUI.visible = true
	else:
		menuUI.get_node("StartButton").set_disabled(true)
		menuUI.get_node("HelpButton").set_disabled(true)
		menuUI.visible = false

func _end_screen_display():
	if !endUI.visible && endTest:
		endUI.get_node("RestartButton").set_disabled(false)
		endUI.get_node("MenuReturn").set_disabled(false)
		endUI.visible = true
	else:
		endUI.get_node("RestartButton").set_disabled(true)
		endUI.get_node("MenuReturn").set_disabled(true)
		endUI.visible = false

# Called whenever a button is pressed in the Numpad during the test.
func _on_Button_button_down(extra_arg_0: String):
	if(currentAnswer.length() < 14):
		match extra_arg_0:
			"Button1":
				currentAnswer += "1"
			"Button2":
				currentAnswer += "2"
			"Button3":
				currentAnswer += "3"
			"Button4":
				currentAnswer += "4"
			"Button5":
				currentAnswer += "5"
			"Button6":
				currentAnswer += "6"
			"Button7":
				currentAnswer += "7"
			"Button8":
				currentAnswer += "8"
			"Button9":
				currentAnswer += "9"
			"Button0":
				currentAnswer += "0"
	if extra_arg_0 == "BackButton":
		currentAnswer.erase(currentAnswer.length() - 1, 1)
	if extra_arg_0 == "PassButton":
		answered = true
		if sequence[sequenceIterator] == "Blind 45":
			verdict += 1
			rightWrongMarks[0] = 1
		_next_in_sequence()
	if extra_arg_0 == "EnterButton":
		answered = true
		_check_answer()
		_next_in_sequence()
		
	displayedNum.text = currentAnswer


func _on_Restart_button_down():
	gameplayControl.visible = true
	gameplayControl.set_process(true)
	endTest = false
	_end_screen_display()
	currentAnswer = ""
	verdict = 0
	sequenceIterator = 0
	timer = maxTime
	for i in rightWrongMarks.size():
		rightWrongMarks[i] = 0
	randomize()
	sequence.shuffle()
	match sequence[sequenceIterator]:
		"Blind 45":
			numPlate.set_texture(blindPlateTex)
		"5":
			numPlate.set_texture(fivePlateTex)
		"6":
			numPlate.set_texture(sixPlateTex)
		"7":
			numPlate.set_texture(sevenPlateTex)
		"15":
			numPlate.set_texture(fifteenPlateTex)
		"26":
			numPlate.set_texture(twentySixPlateTex)


func _on_Start_button_down():
	_main_menu_display()
	_on_Restart_button_down()
	currentAnswer = ""


func _on_MenuReturn_button_down():
	_main_menu_display()
	_end_screen_display()
	gameplayControl.visible = false
	gameplayControl.set_process(false)
	currentAnswer = ""


func _on_HelpButton_button_down():
	_main_menu_display()
	tutorialScreen.visible = true
	tutorialScreen.get_node("ReturnButton").set_disabled(false)

#Returns to the menu from the tutorial/help screen
func _on_ReturnButton_button_down():
	_main_menu_display()
	tutorialScreen.visible = false
	tutorialScreen.get_node("ReturnButton").set_disabled(true)

#return to Main Menu to select another game
func _on_BackButton_button_down():
	get_tree().root.get_node("Root").queue_free()
	get_tree().change_scene("res://MainMenu/Scenes/MainMenuScene.tscn")
