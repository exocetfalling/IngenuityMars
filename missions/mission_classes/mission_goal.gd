extends Node

class_name MissionGoal

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# export(String, "Location", "Time", "Leah") var goal_type
#var goal_data: Array = [Vector3.ZERO, 0.00]
export var goal_location: Vector3 = Vector3.ZERO
export var goal_duration: float = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


#func get_goal_data():
#	return goal_data



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
