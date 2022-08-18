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

func _ready() -> void:
	$BinocularsProjectButton.grab_focus()
	progressBar.value = getProgress()
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

func sendEmail():
	print("email")
	var recipient := "monkegigaman@gmail.com"
	var subject := "Certificate test"
	var body := "Well done " + str(PlayerData.playerName) + ". You are a certified Monke"

	var mailtoCommand := "mailto:" + recipient + "?subject=" + subject.http_escape() + "&body=" + body.http_escape()
	print(mailtoCommand)
	if OS.shell_open(mailtoCommand) == FAILED:
		print("failed to send email")


func _on_Email_button_up():
	# sendEmail()
	var output: Array = []
	
	OS.execute("cmd.exe",
	 ["/c", "Python/Portable Python 3.2.5.1/App/python.exe", "Email/SendEmail.py"], true, output)
		 
	print(output)
