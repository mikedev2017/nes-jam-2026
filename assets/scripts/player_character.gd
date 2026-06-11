class_name PlayerCharacter extends CharacterBody2D

@export_category("Speed")
@export var speed : float = 300
@export var acceleration : float = 10
@export var deceleration : float = 10
@export_category("Jump Handling")
@export var jump_velocity : float = -300
@export var coyote_timer: Timer
@export var coyoteWaitTime: float = 0.15

var is_coyote_time: bool = false
var can_jump: bool = false


func _ready() -> void:
	coyote_timer.wait_time = coyoteWaitTime


func _physics_process(delta: float) -> void:
	
	if is_coyote_time:
		handle_jump()
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Start the coyote time timer when you just walked off a platform	
	if !is_on_floor() and can_jump and !is_coyote_time:
		coyote_timer.start()
		is_coyote_time = true

	if is_on_floor():
		can_jump = true
		handle_jump()
	elif velocity.y < 0.0:
		if Input.is_action_just_released("a_button"):
			velocity.y *= 0.5

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("d_pad_left", "d_pad_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()


func handle_jump():
	if Input.is_action_just_pressed("a_button") and (can_jump or is_coyote_time):
		velocity.y = jump_velocity
		# prevent infinite jumping
		# disable if you want to add double jumping
		can_jump = false


func _on_timer_timeout() -> void:
	is_coyote_time = false


func add_to_inventory(data: ItemData):
	# We pass the data to our Autoload (Singleton)
	InventorySystem.add_item(data)
	
	# Optional: Trigger a visual effect or sound
	print("Player received: " + str(data.name))
	
	# TODO: mark item as collected so that if player dies the item is not added back
