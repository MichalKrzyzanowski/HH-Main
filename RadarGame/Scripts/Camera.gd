extends Spatial

#####################################
#			Variables				#
#####################################
var mouseSpeed = 0.01
var isZooming = false
var movement := Vector2()
var movementWeight := 0.2
onready var slider = $Control/VSlider
var eventId = -1
onready var target = $RayCast
var planeTargeted : Node
var isFound = false

#####################################
#		Public Functions			#
#####################################
func _ready():
	slider.value = $Camera.fov

func _input(event: InputEvent) -> void:
	if get_parent().visible:
		#Mouse movement
		if event is InputEventMouseButton:
			if event.pressed && event.button_index == BUTTON_LEFT:
				eventId = 1
				_resetCamera()
			else:
				eventId = -1
		elif event is InputEventMouseMotion:
			if eventId == 1:
				movement = event.relative * mouseSpeed
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
				movement = event.relative * mouseSpeed
				movement.x += rotation.y
				movement.y += rotation.x


func _process(_delta):
	rotation.x = lerp(rotation.x, movement.y, movementWeight)
	rotation.y = lerp(rotation.y, movement.x, movementWeight)
	rotation.x = clamp(rotation.x,deg2rad(0), deg2rad(90))
	GameData.current_rotation = fmod(rotation_degrees.y, 360)
	$Camera.fov = lerp($Camera.fov, slider.value, 0.2)
	if $Camera.fov <= 60:
		$Binoculars.visible = true
		isZooming = true
	else:
		$Binoculars.visible = false
		isZooming = false

	if get_parent().visible:
		$Control.visible = true
	else:
		$Control.visible = false

	if $Cooldown.time_left <= 0.2:
		target.enabled = true
		$Cooldown.stop()

	if isFound:
		self.global_transform = $Camera.global_transform.looking_at(planeTargeted.global_transform.origin,Vector3.UP)



func _physics_process(delta):
	if target.is_colliding() && !isFound && isZooming:
		planeTargeted = target.get_collider().get_child(0)
		isFound = true



#####################################
#		Signal Functions			#
#####################################
func _on_VSlider_drag_started():
	pass


func _on_VSlider_drag_ended(value_changed:bool):
	pass

func _on_VSlider_gui_input(event: InputEvent):
	if event is InputEventMouseButton:
		if event.pressed:
			eventId = -1
	if event is InputEventScreenTouch:
		if event.pressed:
			eventId = -1


func _resetCamera() -> void:
	if isFound && !isZooming:
		target.enabled = false
		isFound = false
		$Cooldown.wait_time = 2
		$Cooldown.start()
