extends Node2D

var stone = preload("res://Scene/character_body_2d.tscn")


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		
		var s= stone.instantiate()
		s.initialize(get_global_mouse_position())
		get_tree().current_scene.add_child(s)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
