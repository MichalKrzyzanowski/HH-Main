extends Control

func _ready() -> void:
    $Control/Button.grab_focus()

func _input(event: InputEvent) -> void:
    GlobalTimer.reset()

func _on_Button_button_up() -> void:
    get_tree().root.get_node("Root").queue_free()
    SoundManager.playSound("res://ReactionTest/Sounds/BackSound.wav")
    get_tree().change_scene("res://ReactionTest/Scenes/MenuScene.tscn")