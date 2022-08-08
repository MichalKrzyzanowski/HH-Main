extends Control

onready var progressBar = $Control/ProgressBar
onready var statsMenu = $StatsMenu
onready var reactionScoreLabel = $StatsMenu/ReactionTestScore
onready var reactionTimeLabel = $StatsMenu/ReactionTestClearTime
onready var colorBlindVerdictLabel = $StatsMenu/ColorBlindTestVerdict
onready var playerNameLabel = $PlayerName

func _ready() -> void:
	$BinocularsProjectButton.grab_focus()
	progressBar.value = getProgress()
	reactionScoreLabel.text = "Highscore: " + str(ReactionTestData.highscore) + "pts"
	reactionTimeLabel.text = "Clear Time: " + str(ReactionTestData.fastestTime) + "s"
	colorBlindVerdictLabel.text = "Highest Verdict: " + str(ColorBlindData.highestVerdict)
	playerNameLabel.text = "PlayerName: " + str(PlayerData.playerName)

func _on_ColorBlindTestButton_button_up() -> void:
	get_tree().root.get_node("Root").queue_free()
	get_tree().change_scene("res://ColorBlindTest/Scenes/Menu.tscn")


func _on_BinocularsProjectButton_button_up() -> void:
	pass # Replace with function body.

func _on_ReactionTestButton_button_up() -> void:
	get_tree().root.get_node("Root").queue_free()
	get_tree().change_scene("res://ReactionTest/Scenes/MenuScene.tscn")


func _on_QuitButton_button_up() -> void:
	get_tree().root.get_node("Root").queue_free()
	get_tree().change_scene("res://MainMenu/Scenes/SplashScene.tscn")
	ColorBlindData.reset()
	PlayerData.reset()
	ReactionTestData.reset()

func getProgress():
	return ReactionTestData.isCleared as int + ColorBlindData.isGameClear as int

func _on_ProgressBar_gui_input(event:InputEvent) -> void:
	if Input.is_action_just_released("click"):
		statsMenu.visible = !statsMenu.visible
