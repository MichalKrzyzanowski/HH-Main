extends Node

var timer := 0.0
var threshold := 60
var kickTime := threshold + 40

func reset():
    timer = 0.0

func _ready() -> void:
    pause_mode = PAUSE_MODE_PROCESS

func _process(delta: float) -> void:
    timer += delta
    # print("idle time: " + str(timer))

func thresholdReached():
    return timer >= threshold

func getRemainingTime():
    return kickTime - timer

func kickTimeReached():
    return timer >= kickTime