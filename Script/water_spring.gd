extends Node2D

# Spring current velocity
var velocity = 0

# Force to apply to spring
var force = 0

# height of the spring
var height = 0

# Position of the spring
var target_height = 0

var index = 0
var motion_factor = 0.02

signal splash

# Collision
@onready var collision = $Area2D/CollisionShape2D

func water_update (spring_constant, dampening) :
	#update water physics
	height = position.y
	var x = height - target_height
	
	# Dampen
	var loss = - dampening * velocity
	
	# Hooke law
	force = - spring_constant * x + loss

	# Apply velocity
	velocity += force
	
	# Change spring position
	position.y += velocity

func initialize(x_position, id):
	print ("Ok")
	height = position.y
	target_height = position.y
	velocity = 0
	position.x = x_position
	index = id

func set_collision_width(value):
	var extents = collision.shape.get_size()
	var new_extents = Vector2(value / 2, extents.y)
	collision.shape.set_size (new_extents)
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	print ("Hi")
	var speed = 500 * motion_factor
	emit_signal ("splash", index, speed)
