extends Node2D

#Main Menu Variables
var menuUI
var tutorialScreen

# Called when the node enters the scene tree for the first time.
func _ready():
	menuUI = get_node("MainMenu")
	menuUI.visible = true
	tutorialScreen = get_node("TutorialScreen")
	tutorialScreen.visible = false


func _main_menu_display():
	if !menuUI.visible:
		menuUI.get_node("StartButton").set_disabled(false)
		menuUI.get_node("HelpButton").set_disabled(false)
		menuUI.visible = true
	else:
		menuUI.get_node("StartButton").set_disabled(true)
		menuUI.get_node("HelpButton").set_disabled(true)
		menuUI.visible = false


func _on_Start_button_down():
	get_tree().root.get_node("Root").queue_free()
	get_tree().change_scene("res://ColorBlindTest/Scenes/Gameplay.tscn")

func _on_HelpButton_button_down():
	_main_menu_display()
	tutorialScreen.visible = true
	tutorialScreen.get_node("ReturnButton").set_disabled(false)

#Returns to the menu from the tutorial/help screen
func _on_ReturnButton_button_down():
	_main_menu_display()
	tutorialScreen.visible = false
	tutorialScreen.get_node("ReturnButton").set_disabled(true)

#return to Main Menu to select another game
func _on_BackButton_button_down():
	get_tree().root.get_node("Root").queue_free()
	get_tree().change_scene("res://MainMenu/Scenes/MainMenuScene.tscn")
