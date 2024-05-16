extends RigidBody2D
var operando1 = 0
var operando2 = 0
var operacion = 0
var resultado = 0
var respuesta = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	generarOperaciones()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func generarOperaciones():
	generar_numeros()
	operacion = int(randf_range(1, 4)) #Genera un número aleatorio entre 1 y 4
	if(operacion == 1):
		$operador.text = "*"
		resultado = operando1 * operando2
	elif(operacion == 2):
		$operador.text = "+"
		resultado = operando1 + operando2
	elif(operacion == 3):
		validar_resultado()
		$operador.text = "-"
		resultado = operando1 - operando2
	elif(operacion == 4):
		$operador.text = "/"
		resultado /= operando2

func generar_numeros():
	operando1 = int(randf_range(1, 10))
	operando2 = int(randf_range(1, 10))
	$digito1.text = str(operando1)
	$digito2.text = str(operando2)

func validar_division():
	if(operando1 % operando2 != 0):
		generar_numeros()
		validar_division()

func validar_resultado():
	if(resultado < 0):
		generar_numeros()
		validar_resultado()

