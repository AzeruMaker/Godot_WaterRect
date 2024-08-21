extends Node2D
 
# Spring fact
@export var k = 0.015
@export var d = 0.03
@export var spread = 0.0003

# Spring array
var springs  = []
var passes = 5

#distance in pixel between each spring
@export var distance_between_springs = 50.5

# number of spring in the scene
@export var spring_number = 24

#total water body leght
var water_lenght = distance_between_springs * spring_number

@onready var water_spring = preload("res://Scene/water_spring.tscn")
@export var depth = 1000
var target_height = global_position.y
@export var bottom = target_height * depth
@onready var water_polygon = $Water_Polygon


func instantiate ():
	print ("Hello 1")
	pass
	
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(spring_number):
		var x_position = distance_between_springs * i
		var w = water_spring.instantiate()
		add_child(w)
		springs.append(w)
		w.initialize(x_position, i)
		w.set_collision_width(distance_between_springs)
		var callable = Callable(self, "splash")
		w.connect("splash", callable)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for i in springs:
		i.water_update(k,d)

	var left_deltas = []
	var right_deltas = []
	
	for j in range (passes):	
		for i in range (springs.size()):
			left_deltas.append(0)
			right_deltas.append(0)
		
		for i in range (springs.size()):
			if i > 0 :
				left_deltas[i] = spread * (springs[i].height - springs[i-1].height)
				springs[i-1].velocity += left_deltas[i]
			if i < springs.size() - 1: 
				right_deltas[i] = spread * (springs[i].height - springs[i+1].height)
				springs[i+1].velocity += right_deltas[i]
	draw_water_body()
	
func splash (index, speed):
	if (index >= 0 && index < springs.size()):
		springs[index].velocity += speed

func draw_water_body():
	var surface_points = []
	
	for i in range (springs.size()):
			surface_points.append(springs[i].position)

	var first_index = 0
	var last_index = surface_points.size() - 1
	
	var water_polygon_points = surface_points
	water_polygon_points.append(Vector2(surface_points[last_index].x, bottom))
	water_polygon_points.append(Vector2(surface_points[first_index].x, bottom))
	
	water_polygon_points = PackedVector2Array(water_polygon_points) 
	water_polygon.set_polygon (water_polygon_points)
