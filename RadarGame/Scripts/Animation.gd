extends Spatial

onready var animationPlayer = $AnimationPlayer

func _ready() -> void:
	if animationPlayer.get_animation_list().size() < 1:
		return

	var animation = animationPlayer.get_animation_list()[0]
	print(animationPlayer.get_animation_list())
	animationPlayer.play(animation)
