extends Control

onready var progressBar = $Control/ProgressBar
onready var reactionScoreLabel = $StatsMenu/ReactionTestScore
onready var reactionTimeLabel = $StatsMenu/ReactionTestClearTime
onready var statsMenu = $StatsMenu

func _ready() -> void:
	$BinocularsProjectButton.grab_focus()
	progressBar.value = getProgress()
	reactionScoreLabel.text = "Highscore: " + str(ReactionTestData.highscore) + "pts"
	reactionTimeLabel.text = "Clear Time: " + str(ReactionTestData.fastestTime) + "s"

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

func getProgress():
	return ReactionTestData.isCleared as int

func _on_ProgressBar_gui_input(event:InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.pressed:
			statsMenu.visible = !statsMenu.visible
