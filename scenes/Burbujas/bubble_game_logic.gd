extends Node2D
@export var burbuja: PackedScene
var mistakes = 0
var accumulated_delta = 0
var aciertos = 0
var lista_burbujas = []
var timer = null
@export var score = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	start_game()


func start_game():
	_instance_bubble()
	mistakes = 0
	aciertos = 0
	timer = get_tree().create_timer(120) #2 minutes to complete the game
	timer.timeout.connect(end_game)

func end_game():
	timer.stop()
	print("Game Over")
	print("Score: ", aciertos)
	print("Mistakes: ", mistakes)
	#Go back to the main menu
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	accumulated_delta += delta
	#Se ejecuta cada que delta acumulada es 6
	if(accumulated_delta > 4):
		_instance_bubble()
		accumulated_delta = 0

func _input(event):
	#If the user presses the enter key
	if(event is InputEventKey):
		if not event.pressed:
			return
		if(event.keycode == KEY_ENTER):
			_on_input_text_submitted(get_node("%input").text)
			get_node("%input").text = ""
	#If the user presses the backspace key
	if(event is InputEventKey):
		if(event.keycode == KEY_BACKSPACE):
			get_node("%input").text = get_node("%input").text.substr(0, get_node("%input").text.length() - 1)
	#If the user presses any number key
	if(event is InputEventKey):
		if(event.keycode == KEY_0 or event.keycode == KEY_1 or event.keycode == KEY_2 or event.keycode == KEY_3 or event.keycode == KEY_4 or event.keycode == KEY_5 or event.keycode == KEY_6 or event.keycode == KEY_7 or event.keycode == KEY_8 or event.keycode == KEY_9):
			get_node("%input").text = get_node("%input").text + str(event.keycode - 48)

func _on_pad_number_pressed(which):
	get_node("%input").text = get_node("%input").text + str(which)

func _on_area_2d_body_entered_upper_limit(_body):
	if(_body is RigidBody2D):
		mistakes = mistakes + 1
		print("mistakes: ", mistakes)
		lista_burbujas.erase(_body)
		_body.queue_free()
	
func _instance_bubble():
	var burbuja_instance = burbuja.instantiate()
	add_child(burbuja_instance)
	burbuja_instance.position = Vector2(randf_range(0, 800), 0)+$Marker2D.position
	lista_burbujas.append(burbuja_instance)
	
func _on_input_text_submitted(new_text:String):
	var contador = 0
	print("new_text: ", new_text)
	for i in lista_burbujas:
		if(i.evaluar(new_text)):
			contador = contador + 1
			aciertos = aciertos + 1
			lista_burbujas.erase(i)
			i.queue_free()
	if(contador == 0):
		mistakes = mistakes + 1
		print("mistakes: ", mistakes)
	else:
		print("aciertos: ", aciertos)

		
func _on_input_text_changed(_new_text:String):
	# Add your indented block here
	$VBoxContainer/input.text = str(float($VBoxContainer/input.text))

