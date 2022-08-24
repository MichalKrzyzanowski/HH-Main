extends Spatial
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
onready var player = get_tree().root.get_node("Root").get_child(0)

func _ready():
	random.randomize()
	speed = random.randf_range(-15,15)
	behaviour = 1
	match behaviour:
		0:
			xDirection = true
			if speed < 0:
				plane.get_child(0).transform.basis = plane.get_child(0).transform.basis.rotated(
					Vector3(0,1,0), deg2rad(180))
			rotationTarget = Quat(plane.get_child(0).transform.basis)
		1:
			zDirection = true
			plane.get_child(0).transform.basis = plane.get_child(0).transform.basis.rotated(
				Vector3(0,1,0), deg2rad(270))
			if speed < 0:
				plane.get_child(0).transform.basis = plane.get_child(0).transform.basis.rotated(
					Vector3(0,1,0), deg2rad(180))
			rotationTarget = Quat(plane.get_child(0).transform.basis)
			#print(Quat(plane.get_child(0).transform.basis))
			#print(rotationTarget)
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
		plane.get_child(0).transform.basis = Basis(Quat(plane.get_child(0).transform.basis).slerp(rotationTarget, 0.05))
		if plane.transform.origin.distance_to(player.transform.origin) >= 60:
			#print(plane.transform.origin.distance_to(player.transform.origin))
			speed = -speed
			rotationTarget = Quat(plane.get_child(0).transform.basis.rotated(Vector3(0,1,0), deg2rad(180)))
		velocity += plane.transform.basis.x * speed
	elif zDirection:
		if firstTurn:
			plane.get_child(0).transform.basis = Basis(Quat(plane.get_child(0).transform.basis).slerp(
				rotationTarget, 0.05))
		if plane.transform.origin.distance_to(player.transform.origin) >= 60:
			#print(plane.transform.origin.distance_to(player.transform.origin))
			speed = -speed
			print(rotationTarget)
			rotationTarget = Quat(plane.get_child(0).transform.basis.rotated(Vector3(0,1,0), deg2rad(180)))
			print(rotationTarget)
			if !firstTurn:
				firstTurn = true
		velocity += plane.transform.basis.z * speed
	plane.move_and_collide(velocity * delta)
