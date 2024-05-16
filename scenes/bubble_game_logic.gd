extends Node2D
@export var burbuja: PackedScene
var mistakes = 0
var accumulated_delta = 0
var aciertos = 0
var lista_burbujas = []
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	accumulated_delta += delta
	#Se ejecuta cada que delta acumulada es 6
	if(accumulated_delta > 2):
		_instance_bubble()
		accumulated_delta = 0

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

