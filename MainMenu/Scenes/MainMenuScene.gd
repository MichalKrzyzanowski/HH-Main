extends Control

onready var progressBar = $Control/ProgressBar
onready var statsMenu = $StatsMenu
onready var reactionScoreLabel = $StatsMenu/ReactionTestScore
onready var reactionTimeLabel = $StatsMenu/ReactionTestClearTime
onready var colorBlindVerdictLabel = $StatsMenu/ColorBlindTestVerdict
onready var playerNameLabel = $PlayerName
onready var binoScoreLabel = $StatsMenu/BinocularsScore
onready var binoAccuracyLabel = $StatsMenu/BinocularsAccuracy
onready var binoLevelLabel = $StatsMenu/BinocularsLevel
onready var binoTimeLabel = $StatsMenu/BinocularsTime
onready var emailButton = $Email

func _ready() -> void:
	$BinocularsProjectButton.grab_focus()
	progressBar.value = getProgress()
	emailButton.hide()
	reactionScoreLabel.text = "Highscore: " + str(ReactionTestData.highscore) + "pts"
	reactionTimeLabel.text = "Clear Time: " + str(ReactionTestData.fastestTime) + "s"
	colorBlindVerdictLabel.text = "Highest Verdict: " + str(ColorBlindData.highestVerdict)
	binoScoreLabel.text = "Score: " + str(GameData.prevoiusScore)
	binoAccuracyLabel.text = "Accuracy: " + str(GameData.prevoiusAccuracy)
	binoLevelLabel.text = "Level: " + GameData.Levels.keys()[GameData.prevoiusLevel]
	binoTimeLabel.text = "Time: " + str(GameData.prevoiusTime)
	playerNameLabel.text = "PlayerName: " + str(PlayerData.playerName)



func _input(event: InputEvent) -> void:
	GlobalTimer.reset()

func _on_ColorBlindTestButton_button_up() -> void:
	get_tree().root.get_node("Root").queue_free()
	get_tree().change_scene("res://ColorBlindTest/Scenes/Menu.tscn")


func _on_BinocularsProjectButton_button_up() -> void:
	get_tree().root.get_node("Root").queue_free()
	get_tree().change_scene("res://RadarGame/Scenes/MainMenu.tscn")

func _on_ReactionTestButton_button_up() -> void:
	get_tree().root.get_node("Root").queue_free()
	get_tree().change_scene("res://ReactionTest/Scenes/MenuScene.tscn")


func _on_QuitButton_button_up() -> void:
	get_tree().root.get_node("Root").queue_free()
	get_tree().change_scene("res://MainMenu/Scenes/SplashScene.tscn")
	resetData()

func resetData():
	ColorBlindData.reset()
	PlayerData.reset()
	ReactionTestData.reset()
	GameData.fullReset()

func getProgress():
	return ReactionTestData.isCleared as int + ColorBlindData.isGameClear as int + GameData.gameEnd as int

func _on_ProgressBar_gui_input(event:InputEvent) -> void:
	if Input.is_action_just_released("click"):
		statsMenu.visible = !statsMenu.visible
	if event is InputEventScreenTouch:
		if event.pressed:
			statsMenu.visible = !statsMenu.visible

#func _process(delta: float) -> void:
#	if getProgress() >= 1:
#		emailButton.show()
#		progressBar.removeCorners()
#		$AnimationPlayer.play("Flash")

func sendEmail():
	print("email")
	var to := "allexis_alvarico@outlook.com"
	# var to := "HHRECEPTION@ocfair.com"
	var subject := "Certificate of completion"
	var body := "Well done " + str(PlayerData.playerName) + ". You have cleared all the games"
	emailButton.saveImage()

	var currentPath := ProjectSettings.globalize_path(Directory.new().get_current_dir())

	if OS.has_feature("standalone"):
		print("exported build")
		currentPath = OS.get_executable_path().get_base_dir()
	else:
		print("editor")

	yield(emailButton.saveImage(), "completed")
	var command = 'cd ' + currentPath \
	 + ' && Python\\WPy64-31050\\python-3.10.5.amd64\\python.exe Email/SendEmail.py "' \
	 + to + '" "' + subject \
	 + '" "' + body + '" "' + ProjectSettings.globalize_path("user://NamedCert.png") + '"'

	OS.execute('cmd', ['/C', command], false)

	print(command)



#func _on_Email_button_up():
#	if getProgress() >= 1:
#		sendEmail()
#	else:
#		"not all games have been finished!"
#	# sendEmail()
