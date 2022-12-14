extends Node2D

# refs
onready var multiplierLabel = get_node("HUD/Theme/MultiplierLabel")
onready var scoreLabel = get_node("HUD/Theme/ScoreLabel")
onready var timeLeftLabel = get_node("HUD/Theme/TimeLeftLabel")
onready var grid = get_node("CanvasLayer/GridContainer")
onready var quitConfirm = get_node("HUD/Theme/WindowDialog")
onready var endPop = get_node("HUD/Theme/EndPopUp")
onready var shapeScene = preload("res://ReactionTest/Shape/Shape.tscn")

var score := 0.0

var rng := RandomNumberGenerator.new()

var isGameOver := true
export var shapesAmount := 0
var shapesTouched := 0

var timeSpent := 0.0


func _ready() -> void:
	scoreLabel.text = "Score: " + str(score)
	setupShapeGrid()

func shapeTouched():
	shapesTouched += 1
	if shapesTouched >= shapesAmount: endGame()

func endGame():
	isGameOver = true
	ReactionTestData.highscore = max(score, ReactionTestData.highscore)
	ReactionTestData.fastestTime = max(stepify(timeSpent, 0.01), ReactionTestData.fastestTime)
	ReactionTestData.isCleared = true
	endPop.show()
	endPop.get_node("Label2").text = "Final Score: " + String(score)

func setScore(newScore: float) -> void:
	score += newScore
	score = round(score)
	scoreLabel.text = "Score: " + str(score) + "pts"

func setMultiplier(newMultiplier: float):
	multiplierLabel.text = "Multiplier: x" + str(stepify(newMultiplier, 0.01))

func _input(event: InputEvent) -> void:
	GlobalTimer.reset()

func _process(delta: float) -> void:
	if !isGameOver:
		timeSpent += delta
		timeLeftLabel.text = "Time Spent: " + str(stepify(timeSpent, 0.01)) + "s"

func setupShapeGrid():
	for i in shapesAmount:
		var newShape = shapeScene.instance()
		grid.add_child(newShape)
		yield(get_tree().create_timer(0.01), "timeout")
	isGameOver = false

func _on_QuitButton_button_up() -> void:
	if isGameOver == true:
		return

	quitConfirm.show()
	$HUD/Theme/WindowDialog/ConfirmButton.grab_focus()
	get_tree().paused = true
	SoundManager.playSound("res://ReactionTest/Sounds/ConfirmSound.wav")

func _on_ConfirmButton_button_up() -> void:
	get_tree().root.get_node("Root").queue_free()
	get_tree().paused = false
	SoundManager.playSound("res://ReactionTest/Sounds/ConfirmSound.wav")
	get_tree().change_scene("res://ReactionTest/Scenes/MenuScene.tscn")


func _on_CancelButton_button_up() -> void:
	quitConfirm.hide()
	get_tree().paused = false
	SoundManager.playSound("res://ReactionTest/Sounds/BackSound.wav")


func _on_ReplayButton_button_up():
	endPop.hide()
	get_tree().reload_current_scene()
	SoundManager.playSound("res://ReactionTest/Sounds/ConfirmSound.wav")
