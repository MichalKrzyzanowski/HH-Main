extends Node
class_name CommandExecutor

var osType := ""
var mappings = {}

func _init():
	osType = OS.get_name()
	var commands = {
		"X11": "command-linux, %s = arg1. %s = arg2",
		"Windows": "window-window"
	}
	mappings["send-email"] = commands

func run(command : String, args := []):
	print(mappings[command][osType] % args)
