extends Area


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var body_in_area: bool = false
var body_tgt: Node = null


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


# Called every physics frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if body_in_area:
		if body_tgt.get("battery_level"):
			body_tgt.set("battery_level", 100)


func _on_Charger_body_entered(body):
	body_in_area = true
	body_tgt = body


func _on_Charger_body_exited(body):
	body_in_area = false
	body = null
