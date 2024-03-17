extends Node2D

@onready var player: Player = %Player

func _input(event):
	if event.is_action_pressed("ui_accept"):
		player.increase_length()
