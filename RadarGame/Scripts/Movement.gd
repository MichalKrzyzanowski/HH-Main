extends Spatial
#####################################
#		      Variables      			#
#####################################
var random = RandomNumberGenerator.new()
var velocity : Vector3
var speed : float = 10.0
var xDirection = false
var zDirection = false
var orbiting = false
var firstTurn = false
var behaviour : int
var rotationTarget
onready var plane = get_child(0)
var data : GameData.PlaneData
onready var player = get_tree().root.get_node("Root").get_child(0)

#####################################
#		   Public Functions		   	#
#####################################

func _ready():
	random.randomize()
	speed = random.randf_range(-50,50)
	behaviour = random.randi_range(0, 2)
	match behaviour:
		0:
			xDirection = true
			plane.get_child(0).transform.basis = plane.get_child(0).transform.basis.rotated(
				Vector3(0,0,1), deg2rad(180))
			if speed < 0:
				plane.get_child(0).transform.basis = plane.get_child(0).transform.basis.rotated(
					Vector3(0,1,0), deg2rad(180))
			rotationTarget = plane.get_child(0).transform.basis.get_rotation_quat()
		1:
			zDirection = true
			plane.get_child(0).transform.basis = plane.get_child(0).transform.basis.rotated(
				Vector3(0,1,0), deg2rad(90))
			plane.get_child(0).transform.basis = plane.get_child(0).transform.basis.rotated(
				Vector3(0,0,1), deg2rad(180))
			if speed < 0:
				plane.get_child(0).transform.basis = plane.get_child(0).transform.basis.rotated(
					Vector3(0,1,0), deg2rad(180))
			rotationTarget = plane.get_child(0).transform.basis.get_rotation_quat()
		2:
			orbiting = true
			if speed < 0:
				plane.get_child(0).transform.basis = plane.get_child(0).transform.basis.rotated(
					Vector3(0,1,0), deg2rad(180))

func _physics_process(delta: float) -> void:
	velocity = Vector3.ZERO
	if orbiting:
		var tr =  plane.global_transform.looking_at(plane.get_child(0).get_child(0).transform.origin, Vector3.UP)
		plane.global_transform = plane.global_transform.interpolate_with(tr, 0.1)
		velocity += plane.transform.basis.x * speed
	elif xDirection:
		_rotate_plane()
		velocity += plane.transform.basis.x * speed
	elif zDirection:
		_rotate_plane()
		velocity += plane.transform.basis.z * speed
	plane.move_and_collide(velocity * delta)

	data.planePosition = plane.global_transform.origin

func _rotate_plane() -> void:
	plane.get_child(0).transform.basis = Basis(plane.get_child(0).transform.basis.get_rotation_quat().slerp(
			rotationTarget, 0.05))
	if plane.transform.origin.distance_to(player.transform.origin) >= 60:
		speed = -speed
		rotationTarget = plane.get_child(0).transform.basis.rotated(
			Vector3(0, 1, 0), deg2rad(180)).get_rotation_quat()
