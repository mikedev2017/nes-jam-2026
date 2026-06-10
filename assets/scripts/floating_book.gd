extends AnimatableBody2D

@onready var PositionAX: int = $".".position.x 
@onready var PositionAY: int = $".".position.y
@export var PositionBX: int
@export var PositionBY: int
@export var move_left_right: bool = false
@export var speed : float = 100.0 # Pixels per second
@export var target_position: Vector2
@export var is_on_rail: bool = false

@export var AreaTopLeft: Node2D
@export var AreaTopRight: Node2D
@export var AreaBottomRight: Node2D
@export var AreaBottomLeft: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not move_left_right:
		target_position.x = global_position.x
		target_position.y = PositionBY
	
	elif move_left_right:
		target_position.x = PositionBX
		target_position.y = global_position.y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	global_position = global_position.move_toward(target_position, speed * delta)

	# if the platform has reached its target position
	# reset the target position back to that start position
	if global_position == target_position and !is_on_rail:
		# if platform is moving up and down
		if not move_left_right:
			# if platform is at start position, reset target position
			# to the initial target position
			if global_position.y == PositionAY: 
				target_position.x = global_position.x
				target_position.y = PositionBY
			# if platform is at initial target position, 
			# reset target position to the start position
			elif global_position.y != PositionAY:
				target_position.x = global_position.x
				target_position.y = PositionAY
		
		# if platform is moving from side to side
		elif move_left_right:
			if global_position.x == PositionAX: 
				target_position.x = PositionBX
				target_position.y = global_position.y
			elif global_position.x != PositionAX:
				target_position.x = PositionAX
				target_position.y = global_position.y
				
	# if the platform has reached its target position
	# and it's on a rail, set target position to next position on rail
	if global_position == target_position and is_on_rail:			
		#print("You reached target")
		if global_position == AreaTopRight.global_position:
			#print("You entered top right corner")
			move_left_right = false
			target_position = Vector2(global_position.x, AreaBottomRight.global_position.y)
		if global_position == AreaBottomRight.global_position:
			#print("You entered Bottom right corner")
			move_left_right = true
			target_position = Vector2(AreaBottomLeft.global_position.x, global_position.y)
		if global_position == AreaBottomLeft.global_position:
			#print("You entered bottom left corner")
			move_left_right = false
			target_position = Vector2(global_position.x, AreaTopLeft.global_position.y)
		if global_position == AreaTopLeft.global_position:
			#print("You entered top left corner")
			move_left_right = true
			target_position = Vector2(AreaTopRight.global_position.x, global_position.y)	
