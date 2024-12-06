extends Spatial

class_name MissionGoal

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var goal_radius: float = 5
export var goal_duration: float = 60

export var goal_title: String
export var goal_description: String

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


#func get_goal_data():
#	return goal_data



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
