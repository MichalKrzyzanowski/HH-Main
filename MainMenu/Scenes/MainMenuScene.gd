extends Control

func _ready() -> void:
    $BinocularsProjectButton.grab_focus()

func _on_ColorBlindTestButton_button_up() -> void:
	get_tree().root.get_node("Root").queue_free()
	get_tree().change_scene("res://ColorBlindTest/Scenes/ColorBlind.tscn")


func _on_BinocularsProjectButton_button_up() -> void:
	pass # Replace with function body.

func _on_ReactionTestButton_button_up() -> void:
	get_tree().root.get_node("Root").queue_free()
	get_tree().change_scene("res://ReactionTest/Scenes/MenuScene.tscn")


func _on_QuitButton_button_up() -> void:
	get_tree().quit()
