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
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	slider.value = $Camera.fov
	pass

func _input(event: InputEvent) -> void:
	# print("unhandled_input")
	if get_parent().visible && !is_zooming:
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
	rotation.x = clamp(rotation.x,deg2rad(0), deg2rad(60))
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
#			Signals					#
#####################################


#####################################
#		Setter Functions			#
#####################################

#####################################
#		Getter Functions			#
#####################################

func get_rotation() -> Vector3:
	return self.rotation_degrees

func _on_VSlider_drag_started():
	is_zooming = true

func _on_VSlider_drag_ended(value_changed:bool):
	is_zooming = false

func _on_VSlider_gui_input(event: InputEvent):
	if event is InputEventMouseButton:
		if event.pressed:
			eventId = -1
			
	if event is InputEventScreenTouch:
		if event.pressed:
			eventId = -1
