extends VBoxContainer

@onready var resolution_options: OptionButton = $Resolution_Hbox/Resolution_Options
@onready var fullscreen_toggle: CheckButton = $Fullscreen_Hbox/Wrapper/FullscreenToggle
@onready var borderless_toggle: CheckButton = $Borderless_Hbox/Wrapper/BorderlessToggle
@onready var v_sync_check_box: CheckBox = $VSync_Hbox/Wrapper/VSyncCheckBox


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_current_settings()


func load_current_settings():
	var mode = DisplayServer.window_get_mode()
	fullscreen_toggle.button_pressed = mode == DisplayServer.WINDOW_MODE_FULLSCREEN
	borderless_toggle.button_pressed = DisplayServer.window_get_flag(DisplayServer.WINDOW_FLAG_BORDERLESS)
	v_sync_check_box.button_pressed = DisplayServer.window_get_vsync_mode() == DisplayServer.VSYNC_ENABLED


func _on_resolution_options_item_selected(index: int) -> void:
	match index:
		0: DisplayServer.window_set_size(Vector2(1920,1080))
		1: DisplayServer.window_set_size(Vector2(1600,960))
		2: DisplayServer.window_set_size(Vector2(1280,720))
		3: DisplayServer.window_set_size(Vector2(640,480))


func _on_fullscreen_toggle_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_borderless_toggle_toggled(toggled_on: bool) -> void:
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, toggled_on)


func _on_v_sync_check_box_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSyncMode.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSyncMode.VSYNC_DISABLED)
