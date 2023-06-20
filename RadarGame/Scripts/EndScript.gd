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
	if GameData.currentLevel >= GameData.previousLevel:
		GameData.previousLevel = GameData.currentLevel
		if GameData.currentScore > GameData.previousScore && GameData.currentAccuracy > GameData.previousAccuracy:
			GameData.previousAccuracy = GameData.currentAccuracy
			GameData.previousScore = GameData.currentScore
			GameData.previousTime = GameData.currentTime
	OverallScore()

func OverallScore():
	var temp : int
	if GameData.previousLevel == GameData.Levels.Easy:
		temp = (GameData.previousScore * 2) * (GameData.previousTime) * (GameData.previousAccuracy * 2)
	if GameData.previousLevel == GameData.Levels.Normal:
		temp = (GameData.previousScore * 4) * (GameData.previousTime) * (GameData.previousAccuracy * 4)
	if GameData.previousLevel == GameData.Levels.Hard:
		temp = (GameData.previousScore * 6) * (GameData.previousTime) * (GameData.previousAccuracy * 6)
	PlayerData.score = temp
