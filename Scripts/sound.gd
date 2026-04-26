extends Node3D

@onready var sound = $"AudioStreamPlayer3D"

func _ready() -> void:
	sound.playing = true
