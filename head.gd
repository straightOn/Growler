class_name Head extends CharacterBody2D

signal has_collected

func collect():
	has_collected.emit()
