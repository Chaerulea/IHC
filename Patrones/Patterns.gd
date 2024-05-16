extends Node2D

#List of any possible texture we can use, here go piggy, donkey, dog and cat
var textures = [preload("res://assets/Round/pig.png"), preload("res://assets/round/duck.png"), preload("res://assets/round/dog.png"), preload("res://assets/round/cow.png"), preload("res://assets/PNG/BLUE/letter.png")]

@onready var nodes = [
	$CenterContainer/GridContainer/S2D,
	$CenterContainer/GridContainer/S2D3,
	$CenterContainer/GridContainer/S2D2,
	$CenterContainer/GridContainer/S2D4,
	$CenterContainer/GridContainer/S2D5,
	$CenterContainer/GridContainer/S2D6,
	$CenterContainer/GridContainer/S2D7,
	$CenterContainer/GridContainer/S2D8,
	$CenterContainer/GridContainer/S2D9
]

func _enter_tree():
	#Tween animation, from small to big, using ease out
	var tween = get_tree().create_tween()
	tween.tween_property($CenterContainer, "scale", Vector2(0.5,0.5), 1).set_trans(Tween.TRANS_ELASTIC)

func _exit_tree():
	#Tween animation, from big to small, using ease in
	var tween = get_tree().create_tween()
	tween.tween_property($CenterContainer, "scale", Vector2(0,0), 1).set_trans(Tween.TRANS_BOUNCE)

# Called when the node enters the scene tree for the first time.
func _ready():
	#Generate the pattern
	for i in range(9):
		nodes[i].texture = textures[randi() % textures.size()]

