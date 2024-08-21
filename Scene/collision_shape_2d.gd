extends CollisionShape2D

@onready var water_body = preload("res://Scene/water_body.tscn")

func get_num_spring(x_size, max_point):
	var last_point_int = 1
	var max_point_float = max_point
	var last_point_float = 1
	for i in range (1, max_point):
		if x_size % i == 0:
			last_point_int = i
		elif x_size % i < max_point_float:
			max_point_float = x_size % i
			last_point_float = i
	
	if last_point_int > 5 :
		print (last_point_int)
		return last_point_int
	if last_point_float > 5 :
		print (last_point_int)
		return last_point_int	
	else :
		print (max_point)
		return max_point


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var x_size = int (self.shape.get_size().x)
	var spring_number = get_num_spring(int (x_size), 50)

	var w = water_body.instantiate()	
	w.distance_between_springs = x_size / spring_number
	w.spring_number = spring_number + 1
	w.bottom = self.shape.get_size().y
	w.position.y = self.position.y -  self.shape.get_size().y
	w.position.x = self.position.x -  x_size 
	add_child(w)
