extends Control

#####################################
#		Public Functions			#
#####################################
func _ready():
	_getBestResult()
	$Panel/VBoxContainer/Score.text = "Score: " + str(GameData.currentScore) + "/" + str(GameData.enemyAmount)
	$Panel/VBoxContainer/Percentage.text = "Percentage: " + str(GameData.currentAccuracy) + "%"
	$Panel/VBoxContainer/Time.text = "Time: " + str(GameData.currentTime)
	$Panel/VBoxContainer/Level.text = "level: " +  GameData.Levels.keys()[GameData.currentLevel]

func _input(event: InputEvent):
	GlobalTimer.reset()

#####################################
#		Signals	Functions			#
#####################################
func _on_MainMenuButton_pressed():
	GameData.gameReset()
	get_tree().change_scene("res://RadarGame/Scenes/MainMenu.tscn")

func _on_PlayButton_pressed():
	GameData.gameReset()
	get_tree().change_scene("res://RadarGame/Scenes/GameplayScreen.tscn")

#####################################
#		Getter Functions			#
#####################################
func _getBestResult():
	GameData.gameEnd = true
	GameData.currentAccuracy = (GameData.currentScore / GameData.enemyAmount) * 100
	if GameData.currentLevel >= GameData.prevoiusLevel:
		GameData.prevoiusLevel = GameData.currentLevel
		if GameData.currentScore > GameData.prevoiusScore && GameData.currentAccuracy > GameData.prevoiusAccuracy:
			GameData.prevoiusAccuracy = GameData.currentAccuracy
			GameData.prevoiusScore = GameData.currentScore
			GameData.prevoiusTime = GameData.currentTime
