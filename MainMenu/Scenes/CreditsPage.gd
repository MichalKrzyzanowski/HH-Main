extends Control

func _input(event: InputEvent) -> void:
	GlobalTimer.reset()

#return to Main Menu to select another game
func _on_ReturnButton_button_down():
	get_tree().root.get_node("Root").queue_free()
	get_tree().change_scene("res://MainMenu/Scenes/MainMenuScene.tscn")
