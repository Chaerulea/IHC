extends Node2D
@export var burbuja: PackedScene
var mistakes = 0
var accumulated_delta = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#Se ejecuta cada que delta acumulada es 6
	if(accumulated_delta > 6):
		_instance_bubble()
		accumulated_delta = 0
	accumulated_delta += delta


func _on_area_2d_body_entered_upper_limit(_body):
	if(_body is RigidBody2D):
		mistakes = mistakes + 1
		print("mistakes: ", mistakes)
		_body.queue_free()
	
func _instance_bubble():
	var burbuja_instance = burbuja.instantiate()
	add_child(burbuja_instance)
	burbuja_instance.position = Vector2(randf_range(0, 800), 0)+$Marker2D.position

