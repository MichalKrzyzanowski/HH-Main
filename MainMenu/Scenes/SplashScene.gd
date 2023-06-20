extends Control

var firstChar : String = "A"
var secondChar : String = "A"
var thirdChar : String = "A"
var firstCharLabel
var secondCharLabel
var thirdCharLabel


# Get the VerticalContainer node
onready var vertical_container = get_node("ScoreboardPanel/VBoxContainer")

# Called when the node enters the scene tree for the first time.
func _ready():
	firstChar = "A"
	secondChar = "A"
	thirdChar = "A"
	get_node("StartButton").set_disabled(false)
	get_node("StartButton").visible = true
	get_node("NameEntry").visible = false
	get_node("PaperBG").visible = false
	get_node("ChalkBG").visible = true
	get_node("Hh-main-plane").visible = false
	firstCharLabel = get_node("NameEntry/FirstChar")
	secondCharLabel = get_node("NameEntry/SecondChar")
	thirdCharLabel = get_node("NameEntry/ThirdChar")
	firstCharLabel.text = "A"
	secondCharLabel.text = "A"
	thirdCharLabel.text = "A"
	scoreBoardSetup()


func _input(event: InputEvent) -> void:
	GlobalTimer.reset()

func _on_EnterButton_button_down():
	PlayerData.playerName = firstChar + secondChar + thirdChar
	get_tree().root.get_node("Root").queue_free()
	get_tree().change_scene("res://MainMenu/Scenes/MainMenuScene.tscn")

func _on_QuitButton_button_up() -> void:
	get_tree().quit()

func _on_StartButton_button_down():
	get_node("StartButton").set_disabled(true)
	get_node("StartButton").visible = false
	get_node("QuitButton").set_disabled(true)
	get_node("QuitButton").visible = false
	get_node("ScoreboardButton").set_disabled(true)
	get_node("ScoreboardButton").visible = false
	get_node("NameEntry").visible = true
	get_node("PaperBG").visible = true
	get_node("ChalkBG").visible = false
	get_node("Hh-main-plane").visible = true

func _on_IncreaseButton_button_down(extra_arg_0:String):
	match extra_arg_0:
		"FirstChar":
			if ord(firstChar) == 90:
				firstChar = "A"
			else:
				firstChar = char(ord(firstChar) + 1)
			firstCharLabel.text = firstChar
		"SecondChar":
			if ord(secondChar) == 90:
				secondChar = "A"
			else:
				secondChar = char(ord(secondChar) + 1)
			secondCharLabel.text = secondChar
		"ThirdChar":
			if ord(thirdChar) == 90:
				thirdChar = "A"
			else:
				thirdChar = char(ord(thirdChar) + 1)
			thirdCharLabel.text = thirdChar

func _on_DecreaseButton_button_down(extra_arg_0:String):
	match extra_arg_0:
		"FirstChar":
			if ord(firstChar) == 65:
				firstChar = "Z"
			else:
				firstChar = char(ord(firstChar) - 1)
			firstCharLabel.text = firstChar
		"SecondChar":
			if ord(secondChar) == 65:
				secondChar = "Z"
			else:
				secondChar = char(ord(secondChar) - 1)
			secondCharLabel.text = secondChar
		"ThirdChar":
			if ord(thirdChar) == 65:
				thirdChar = "Z"
			else:
				thirdChar = char(ord(thirdChar) - 1)
			thirdCharLabel.text = thirdChar


func _on_ScoreboardButton_button_down():
	get_node("ScoreboardPanel").visible = true

func _on_BackButton_button_down():
	get_node("ScoreboardPanel").visible = false

func scoreBoardSetup():
	var player_data =  PlayerData.leaderboard.get_rank_list()

	for key in player_data.keys():
		var index = int(key)
		var player_label = vertical_container.get_child(index)
		player_label.text = str(index + 1) + ". " + player_data[key]["Name"] + "             " + str(player_data[key]["Score"])
