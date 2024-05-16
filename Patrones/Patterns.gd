extends Control

#List of any possible texture we can use, here go piggy, donkey, dog and cat
var textures = [preload("res://assets/Round/pig.png"), preload("res://assets/round/duck.png"), preload("res://assets/round/dog.png"), preload("res://assets/round/cow.png"), preload("res://assets/PNG/BLUE/letter.png")]
var duplicate_from = []

signal selected(node)
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

func remove():
	#Tween animation, from big to small, using ease in
	var tween = get_tree().create_tween()
	tween.tween_property($CenterContainer, "scale", Vector2(0,0), 0.7).set_trans(Tween.TRANS_SPRING)
	await tween.finished
	#Remove the node from the scene tree
	queue_free()

# Called when the node enters the scene tree for the first time.
func _ready():
	#Generate the pattern
	$CenterContainer/Button.pressed.connect(_on_Button_pressed)
	if duplicate_from.size() == 0:
		for i in range(9):
			nodes[i].texture = textures[randi() % textures.size()]
	else:
		for i in range(9):
			nodes[i].texture = duplicate_from[i].texture

func _on_Button_pressed():
	#Emit the signal to the parent
	emit_signal("selected", self)

func select():
	#Select the node, visually
	$CenterContainer/ColorRect.visible = true

func deselect():
	#Deselect the node, visually
	$CenterContainer/ColorRect.visible = false
