extends Control


func _on_PlayButton_pressed():
	$CenterContainer.visible = false;
	$DifficultyContainer.visible = true
	$Difficulty.visible = true

func _on_TutorialButton_pressed():
	pass # TODO create a help screen


func _on_QuitButton_pressed():
	get_tree().root.get_node("Control").queue_free()
	get_tree().change_scene("res://MainMenu/Scenes/MainMenuScene.tscn")

func _on_EasyButton_pressed():
	GameData.enemyAmount = 6
	startGame()

func _on_HardButton_pressed():
	GameData.enemyAmount = 9
	startGame()

func _on_NormalButton_pressed():
	GameData.enemyAmount = 12
	startGame()

func startGame():
	get_tree().root.get_node("Control").queue_free()
	get_tree().change_scene("res://RadarGame/Scenes/GameplayScreen.tscn")
