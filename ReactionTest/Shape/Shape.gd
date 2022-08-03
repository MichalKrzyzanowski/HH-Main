tool
extends TextureRect

onready var audioPlayer = get_node("AudioStreamPlayer")
onready var touchController = get_tree().root.get_node("Root")
onready var circleSpinner = get_tree().root.get_node("Root/CanvasLayer/CircleSpinner")
onready var explosionScene = preload("res://ReactionTest/Explosion/explosion.tscn")

var timeElapsed := 0.0
var eventId := -1

export(Color) var inactiveColor
export(Color) var activeColor

var isActive := true

onready var tween := get_node("Tween")

func _ready() -> void:
	modulate = activeColor
	modulate.a = 0.0
	tween.interpolate_property(self, "modulate:a", 0.0, 1.0, 0.1, Tween.TRANS_CUBIC, Tween.EASE_OUT_IN)
	tween.start()

func _process(delta: float) -> void:
	timeElapsed += delta
	if touchController != null:
		if circleSpinner.getIsActive():
			modulate = modulate.linear_interpolate(activeColor, 0.2)
		else:
			modulate = modulate.linear_interpolate(inactiveColor, 0.2)

func _on_Shape_gui_input(event:InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.pressed:
			eventId = event.index
			if eventId > 0 && circleSpinner.getIsActive() && !touchController.isGameOver && \
				isActive:
					isActive = false
					touchController.setScore(circleSpinner.scoreMultiplier)
					activeColor = inactiveColor
					touchController.shapeTouched()
					$AnimationPlayer.play("Spin")
					playSound()
		else:
			eventId = -1

func playSound():
	randomize()
	audioPlayer.pitch_scale = touchController.rng.randf_range(0.8, 1.2)
	audioPlayer.playing = true
