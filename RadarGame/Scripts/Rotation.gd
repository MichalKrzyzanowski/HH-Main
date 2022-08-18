extends Sprite
#####################################
#			Variables				#
#####################################
var rotation_speed = 60

#####################################
#		Public Functions			#
#####################################
func _process(delta):
	self.rotation_degrees += rotation_speed * delta