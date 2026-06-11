extends Node

var has_grimoire: bool = false
var player_killed : bool

#HUD
var gem_count : int = 0
var player_lives : int = 3
var score : int = 0

func _ready() -> void:
	player_killed = false

func _process(_delta: float) -> void:
	if player_killed == true:
		SceneLoader.load_scene("res://scenes/tilemap_prototype.tscn")
		player_killed = false
		
	# Display HUD

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("dev_exit"):
		get_tree().quit()
	if event.is_action_pressed("dev_reload"):
		get_tree().reload_current_scene()
