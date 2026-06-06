extends Control


func _on_start_pressed() -> void:
	SceneLoader.load_scene("res://levels/testing_sandbox_level_2.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
