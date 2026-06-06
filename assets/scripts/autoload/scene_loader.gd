extends Node

# Reference: Queble - Load and Switch Scenes - https://www.youtube.com/watch?v=m4PfHg3hmSo

signal progress_changed(progress)
signal load_finished

var loading_screen: PackedScene = preload("res://scenes/loading_screen.tscn")
var loaded_resource: PackedScene
var scene_path: String
var progress: Array = []
# The Resource Loader will try to use multiple CPU threads to load the scene in the background.  If this doesn't work, set to false.
var use_sub_threads: bool = true

# This function will use process to constantly check if our resource has been loaded
func _ready() -> void:
	set_process(false)


func load_scene(_scene_path: String) -> void:
	# Level/Scene path goes here
	scene_path = _scene_path
	
	# Instantiate a new Loading Screen scene and add it to the SceneTree
	var new_load_screen = loading_screen.instantiate()
	add_child(new_load_screen)
	# Connect the signals to the Loading Screen progress_changed and load_finished functions
	progress_changed.connect(new_load_screen._on_progress_changed)
	load_finished.connect(new_load_screen._on_load_finished)
	# Wait for the Loading Screen to emit it's loading_screen_ready signal
	await new_load_screen.loading_screen_ready
	
	start_load()


func start_load() -> void:
	var state = ResourceLoader.load_threaded_request(scene_path, "", use_sub_threads)
	if state == OK:
		set_process(true)


func _process(_delta: float) -> void:
	var load_status = ResourceLoader.load_threaded_get_status(scene_path, progress)
	progress_changed.emit(progress[0])
	match load_status:
		ResourceLoader.THREAD_LOAD_INVALID_RESOURCE, ResourceLoader.THREAD_LOAD_FAILED:
			set_process(false)
		ResourceLoader.THREAD_LOAD_LOADED:
			loaded_resource = ResourceLoader.load_threaded_get(scene_path)
			get_tree().change_scene_to_packed(loaded_resource)
			load_finished.emit()
