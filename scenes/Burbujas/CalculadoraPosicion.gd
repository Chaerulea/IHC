extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().root.size_changed.connect(_on_size_changed)


func _on_size_changed():
	position = get_viewport_rect().size /2
