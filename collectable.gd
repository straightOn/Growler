extends Area2D

func _on_body_entered(body):
	if body is Head:
		body.collect()
		var rand_vector = Vector2(
			randf_range(50, -50),
			randf_range(50, -50))
		global_position = global_position + rand_vector
