extends AnimatableBody2D

@onready var PositionAX: int = $".".position.x 
@onready var PositionAY: int = $".".position.y
@export var PositionBX: int
@export var PositionBY: int
@export var move_left_right: bool = false
@export var speed : float = 100.0 # Pixels per second
@export var target_position: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not move_left_right:
		target_position.x = global_position.x
		target_position.y = PositionBY
	
	elif move_left_right:
		target_position.x = PositionBX
		target_position.y = global_position.y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position = global_position.move_toward(target_position, speed * delta)

	if global_position == target_position:
		if not move_left_right:
			if global_position.y == PositionAY: 
				target_position.x = global_position.x
				target_position.y = PositionBY
			elif global_position.y != PositionAY:
				target_position.x = global_position.x
				target_position.y = PositionAY
	
		elif move_left_right:
			if global_position.x == PositionAX: 
				target_position.x = PositionBX
				target_position.y = global_position.y
			elif global_position.x != PositionAX:
				target_position.x = PositionAX
				target_position.y = global_position.y
				
			
	#var next_pos = global_position.move_toward(target_position, speed * delta)
	#print("Current: ", global_position, " -> Next: ", next_pos)
	#global_position = next_pos
