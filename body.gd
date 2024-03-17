class_name Body extends RigidBody2D

const DISTANCE = 30

var next_element: Body
var parent: Node2D

var positions: Array[Vector2] = []

func set_parent(_parent: Node2D):
	parent = _parent

func add_element(_next_element: Body):
	if next_element:
		next_element.add_element(_next_element)
	else:
		next_element = _next_element
		next_element.set_parent(self)
		next_element.global_position = global_position
	
func add_position(_new_position: Vector2):
	positions.append(_new_position)
	
func _physics_process(delta):
	if !parent:
		return
	if positions.is_empty():
		return
	if parent.global_position.distance_to(global_position) > DISTANCE:
		var next_position = positions.pop_back()
		global_position = next_position
		if next_element:
			next_element.add_position(next_position)
	
