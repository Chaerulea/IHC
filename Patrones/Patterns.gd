extends Node2D

#List of any possible texture we can use, here go piggy, donkey, dog and cat
var textures = [preload("res://piggy.png"), preload("res://donkey.png"), preload("res://dog.png"), preload("res://cat.png"), preload("res://empty.png")]

@onready var nodes = [
	$GridContainer/S2D,
	$GridContainer/S2D2,
	$GridContainer/S2D3,
	$GridContainer/S2D4,
	$GridContainer/S2D5,
	$GridContainer/S2D6,
	$GridContainer/S2D7,
	$GridContainer/S2D8,
	$GridContainer/S2D9
]

func _enter_tree():
	#Tween animation, from small to big, using ease out
	var tween = Tween.new()
	tween.interpolate_property(self, "scale", Vector2(0, 0), Vector2(1, 1), 1, Tween.TRANS_QUAD, Tween.EASE_OUT_IN)
	tween.start(self, "scale")

func _exit_tree():
	#Tween animation, from big to small, using ease in
	var tween = Tween.new()
	tween.interpolate_property(self, "scale", Vector2(1, 1), Vector2(0, 0), 1, Tween.EASE_IN, Tween.EASE_IN_OUT)

# Called when the node enters the scene tree for the first time.
func _ready():
	#Generate the pattern
	for i in range(9):
		nodes[i].texture = textures[randi() % textures.size()]



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
