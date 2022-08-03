extends Control

func _ready() -> void:
    $Control/Button.grab_focus()

func _on_Button_button_up() -> void:
    get_tree().root.get_node("Root").queue_free()
    get_tree().change_scene("res://ReactionTest/Scenes/MenuScene.tscn")