extends Control

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_start_pressed() -> void:
	SceneLoader.load_scene("res://scenes/main.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
