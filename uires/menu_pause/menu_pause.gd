extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	# If running in webpage, hide exit button 
	# User can just close browswer tab
	# Using the button makes it freeze in the browser anyway
	if OS.has_feature("HTML5"):
		$Options/ButtonExit.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if($Options/ButtonMainMenu.button_pressed == true):
		get_tree().paused = false
		get_tree().change_scene_to_file("res://uires/menu_main/menu_main.tscn")
	
	if($Options/ButtonResume.button_pressed == true):
		visible = false
		get_tree().paused = false
	
	if ($Options/ButtonSettings.button_pressed == true):
		visible = false
		get_tree().paused = false
		get_tree().change_scene_to_file("res://uires/menu_settings/menu_settings.tscn")
	
	if($Options/ButtonExit.button_pressed == true):
		get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
		get_tree().quit()
		pass
