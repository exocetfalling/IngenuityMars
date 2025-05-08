@tool
extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
@export var label_displayed : String = "Label"
@export var value_displayed : float = 0
@export var value_maximum : float = 999
@export var value_minimum : float = -999
@export var value_char_width : float = 4
@export var value_with_sign : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Engine.is_editor_hint():
		pass
		# Code to execute in editor.

	if not Engine.is_editor_hint():
		pass
		# Code to execute in game.

	# Code to execute both in editor and in game.
	value_displayed = clamp(value_displayed, value_minimum, value_maximum)
	
	$Label.text = label_displayed
	if (value_with_sign == true):
		$Value.text = ("%+04d" % [value_displayed])
	else:
		$Value.text = ("%03d" % [value_displayed])
