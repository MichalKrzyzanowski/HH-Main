extends ProgressBar

onready var styleboxRes = preload("res://MainMenu/UI/ProgressBarStyle.tres")

func _ready() -> void:
	add_stylebox_override("fg", styleboxRes)

func removeCorners():
	styleboxRes.corner_radius_bottom_right = 0
	styleboxRes.corner_radius_top_right = 0
