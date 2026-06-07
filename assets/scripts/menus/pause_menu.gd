extends Control

@export var animation_player: AnimationPlayer

func _ready() -> void:
	hide()


func _process(delta: float) -> void:
	pause_pressed()


func pause() -> void:
	show()
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE) 
	animation_player.play("blur")


func resume() -> void:
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	animation_player.play_backwards("blur") 
	await animation_player.animation_finished
	hide()


func pause_pressed() -> void:
	if Input.is_action_just_pressed("start_button"):
		if get_tree().paused:
			resume()
		else:
			pause()


func _on_resume_pressed() -> void:
	resume()


func _on_restart_pressed() -> void:
	resume()
	get_tree().reload_current_scene()


func _on_quit_pressed() -> void:
	resume()
	SceneLoader.load_scene("res://scenes/main_menu.tscn")
