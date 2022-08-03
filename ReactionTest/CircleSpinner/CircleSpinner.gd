extends TextureProgress

onready var center = get_node("Center")
onready var timer = get_node("Timer")
onready var touchController = get_tree().root.get_node("Root")

var isActive := false

var eventId := -1

var scoreMultiplier: float
var scoreMultiplierSpeed := 0.0

func _physics_process(_delta: float) -> void:
	if !isActive:
		value = -180.0
		tint_under = tint_under.linear_interpolate(Color(0.83, 0.83, 0.83), 0.2)
		scoreMultiplier = max(0.0, scoreMultiplier - 0.05)
	else:
		tint_under = tint_under.linear_interpolate(Color(1, 1, 1), 0.2)
		scoreMultiplier = min(10.0, scoreMultiplier + scoreMultiplierSpeed)
	touchController.setMultiplier(scoreMultiplier)



func _on_TextureProgress_value_changed(_value:float) -> void:
	isActive = true
	timer.start()

func getIsActive():
	return isActive

func _on_Timer_timeout() -> void:
	isActive = false

func _on_TextureProgress_gui_input(event:InputEvent) -> void:
	# print(rad2deg(center.global_rotation))
	if event is InputEventScreenTouch:
		if event.pressed:
			eventId = event.index
		else:	
			eventId = -1
	elif event is InputEventScreenDrag:
		if eventId == event.index && !touchController.isGameOver:
			var dir = (get_global_mouse_position() - center.global_position).normalized()
			center.global_rotation = dir.angle()
			value = lerp(value, rad2deg(center.global_rotation), 0.8)
			# $DoorwheelTexture.rotate(value)
			set_rotation(lerp_angle(get_rotation(), center.global_rotation, 0.2))
			# scoreMultiplier = round(scoreMultiplier)
			scoreMultiplierSpeed = event.relative.length() / 5000
			print(scoreMultiplierSpeed)

