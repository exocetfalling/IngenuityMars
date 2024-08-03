extends Mission


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	title_text = ""
	goals_text = [ \
		"",
		""
	]
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Charger.body_in_area:
		is_complete = true
	pass
