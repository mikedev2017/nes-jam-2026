extends CanvasLayer

# Reference: Queble - Load and Switch Scenes - https://www.youtube.com/watch?v=m4PfHg3hmSo

signal loading_screen_ready

@export var animation_player: AnimationPlayer

func _ready() -> void:
	# The animation_player is set to Autoplay on Load
	await animation_player.animation_finished
	loading_screen_ready.emit()


func _on_progress_changed(_new_value:float) -> void:
	# Use this to add a Loading Bar, Loading Animation or something else
	pass


func _on_load_finished() -> void:
	# When the Autoloader -> Scene Loader is finished loading the scene, reveal the scene, wait for animation to finish then queue free this LoadingScreen from memory
	animation_player.play_backwards("transition")
	await animation_player.animation_finished
	queue_free()
