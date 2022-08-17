extends Control

func _input(event: InputEvent) -> void:
	GlobalTimer.reset()

func _on_PlayButton_pressed():
	$CenterContainer.visible = false;
	$DifficultyContainer.visible = true
	$DifficultyLabel.visible = true

func _on_TutorialButton_pressed():
	pass # TODO create a help screen


func _on_QuitButton_pressed():
	get_tree().root.get_node("Root").queue_free()
	get_tree().change_scene("res://MainMenu/Scenes/MainMenuScene.tscn")

func _on_EasyButton_pressed():
	GameData.enemyAmount = 6
	GameData.currentLevel = GameData.Levels.Easy
	startGame()

func _on_NormalButton_pressed():
	GameData.enemyAmount = 9
	GameData.currentLevel = GameData.Levels.Normal
	startGame()

func _on_HardButton_pressed():
	GameData.enemyAmount = 12
	GameData.currentLevel = GameData.Levels.Hard
	startGame()

func startGame():
	get_tree().root.get_node("Root").queue_free()
	get_tree().change_scene("res://RadarGame/Scenes/GameplayScreen.tscn")


func _on_BackButton_pressed():
	$CenterContainer.visible = true
	$DifficultyContainer.visible = false
	$DifficultyLabel.visible = false
