extends Control

func _ready() -> void:
	$Control/PlayButton.grab_focus()

func _input(event: InputEvent) -> void:
	GlobalTimer.reset()

func _on_PlayButton_button_up() -> void:
	get_tree().root.get_node("Root").queue_free()
	SoundManager.playSound("res://ReactionTest/Sounds/ConfirmSound.wav")
	get_tree().change_scene("res://ReactionTest/Scenes/ReactionScene.tscn")

func _on_HelpButton_button_up() -> void:
	get_tree().root.get_node("Root").queue_free()
	SoundManager.playSound("res://ReactionTest/Sounds/ConfirmSound.wav")
	get_tree().change_scene("res://ReactionTest/Scenes/HelpScene.tscn")

func _on_BackButton_button_up() -> void:
	get_tree().root.get_node("Root").queue_free()
	SoundManager.playSound("res://ReactionTest/Sounds/BackSound.wav")
	get_tree().change_scene("res://MainMenu/Scenes/MainMenuScene.tscn")
