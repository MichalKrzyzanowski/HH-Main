extends Spatial

#####################################
#			Variables				#
#####################################
var mouse_speed = 0.01
var is_zooming = false
var movement := Vector2()
var movementWeight := 0.2
onready var slider = $Control/VSlider
var eventId = -1

#####################################
#		Public Functions			#
#####################################
func _ready():
	slider.value = $Camera.fov

func _input(event: InputEvent) -> void:
	if get_parent().visible && !is_zooming:
		#Mouse movement
		if event is InputEventMouseButton:
			if event.pressed && event.button_index == BUTTON_LEFT:
				eventId = 1
			else:
				eventId = -1
		elif event is InputEventMouseMotion:
			if eventId == 1:
				movement = event.relative * mouse_speed
				movement.x += rotation.y
				movement.y += rotation.x
		#touch movement
		if event is InputEventScreenTouch:
			if event.pressed:
				eventId = event.index
			else:
				eventId = -1
		elif event is InputEventScreenDrag:
			if eventId == event.index:
				movement = event.relative * mouse_speed
				movement.x += rotation.y
				movement.y += rotation.x

func _process(_delta):
	rotation.x = lerp(rotation.x, movement.y, movementWeight)
	rotation.y = lerp(rotation.y, movement.x, movementWeight)
	rotation.x = clamp(rotation.x,deg2rad(0), deg2rad(90))
	GameData.current_rotation = fmod(rotation_degrees.y, 360)
	$Camera.fov = lerp($Camera.fov, slider.value, 0.2)
	if $Camera.fov <= 65:
		$Binoculars.visible = true
	else:
		$Binoculars.visible = false
	if get_parent().visible:
		$Control.visible = true
	else:
		$Control.visible = false

#####################################
#		Signal Functions			#
#####################################
func _on_VSlider_drag_started():
	is_zooming = true

func _on_VSlider_drag_ended(value_changed:bool):
	is_zooming = value_changed

func _on_VSlider_gui_input(event: InputEvent):
	if event is InputEventMouseButton:
		if event.pressed:
			eventId = -1
	if event is InputEventScreenTouch:
		if event.pressed:
			eventId = -1