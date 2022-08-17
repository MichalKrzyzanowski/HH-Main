extends Sprite

var rotation_speed = 60

func _process(delta):
	self.rotation_degrees += rotation_speed * delta