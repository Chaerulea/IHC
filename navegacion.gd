extends TabContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_button_pressed_cuentanos():
	set_current_tab(1)
	print(("Cuentanos"))
	
func _on_button_pressed_estadisticas():
	set_current_tab(3)
	print(("Estadisticas"))

func _on_button_pressed_cuentanos_regresar():
	set_current_tab(2)
	print(("Regresando desde cuentanos"))

func _on_button_pressed_regresar_estadisticas():
	set_current_tab(2)
	print(("Regresando desde estadisticas"))

func _on_button_pressed_iniciar():
	set_current_tab(2)
	print(("Inicializando"))