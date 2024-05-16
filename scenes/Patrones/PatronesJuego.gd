extends Control

var selected = [] #Only two elements can be selected at a time
var pairs = {}

@onready var container : GridContainer= $HBoxContainer/VBoxContainer/GridContainer
@export var pattern : PackedScene

var mistakes = 0
var score = 0
var level = 2
var timer = null

# Called when the node enters the scene tree for the first time.
func _ready():
	start_game()
	populate_level(level)

func start_game():
	mistakes = 0
	score = 0
	level = 2
	timer = get_tree().create_timer(120) #2 minutes to complete the game
	timer.timeout.connect(end_game)

func end_game():
	print("Game Over")
	print("Score: ", score)
	print("Mistakes: ", mistakes)
	print("Level: ", level)
	#Go back to the main menu

func _on_pattern_selected(pattern_node):
	if pattern_node in selected:
		selected.erase(pattern_node)
		pattern_node.deselect()
	else:
		selected.append(pattern_node)
		pattern_node.select()
	if selected.size() == 2:
		if pairs[selected[0]] == selected[1]:
			selected[0].remove()
			selected[1].remove()
			score += 1
			pairs.erase(pairs[selected[0]])
			pairs.erase(selected[0])
			selected = []
			if pairs.size() == 0:
				level += 1
				populate_level(level)
		else:
			selected[0].deselect()
			selected[1].deselect()
			mistakes += 1
			selected = []


func populate_level(difficulty):
	print(ceil(difficulty/3.0))
	for i in range(ceil(difficulty/3.0)):
		var new_pattern = pattern.instantiate()
		container.add_child(new_pattern)
		var duplicated = new_pattern.duplicate()
		duplicated.duplicate_from = new_pattern.nodes
		container.add_child(duplicated)
		duplicated.selected.connect(_on_pattern_selected )
		new_pattern.selected.connect(_on_pattern_selected)
		pairs[new_pattern] = duplicated
		pairs[duplicated] = new_pattern
	randomize_children()

func randomize_children():
	var children = container.get_children()
	for i in range(children.size()):
		var random_index = randi() % children.size()
		container.move_child(children[i], random_index)
