extends AnimatableBody2D

@export var speed : float = 100.0 # Pixels per second
var target_position: Vector2

@export var POS01: Node2D
@export var POS02: Node2D
@export var POS03: Node2D
@export var POS04: Node2D
@export var POS05: Node2D
@export var POS06: Node2D
@export var POS07: Node2D
@export var POS08: Node2D
@export var POS09: Node2D
@export var POS10: Node2D

# Array to hold target positions on the track for the platform to move on
var targetPositions: Array[Node2D]

# Current position in array
var currentTargetNode: int = 1

var readArrayInReverse: bool = false

@export var loopMovement: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	targetPositions.append(POS01)
	targetPositions.append(POS02)
	targetPositions.append(POS03)
	targetPositions.append(POS04)
	targetPositions.append(POS05)
	targetPositions.append(POS06)
	targetPositions.append(POS07)
	targetPositions.append(POS08)
	targetPositions.append(POS09)
	targetPositions.append(POS10)
	#print("size of array is " + str(targetPositions.size()))
	target_position = targetPositions[1].global_position
	#print("global position x of node is " + str(targetPositions[1].global_position.x))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	global_position = global_position.move_toward(target_position, speed * delta)
	#print("Target pos.x is " + str(target_position.x) + " and Target pos.y is " + str(target_position.y))
	if !readArrayInReverse:
		# if the platform has reached its target position
		# move to the next target position
		if global_position == target_position:
			# if you've reached the last node in the array, 
			# count down to go to previous node to move backwards
			if currentTargetNode == (targetPositions.size() - 1):
				# if loop movement go to the first node
				if loopMovement:
					currentTargetNode = 0
					target_position = targetPositions[currentTargetNode].global_position
				# if not loop movement reverse movement
				if !loopMovement:
					#print("Reached last node in array, reverse reverse")
					currentTargetNode -= 1
					target_position = targetPositions[currentTargetNode].global_position
					readArrayInReverse = true
			else:
				# if the next node is null, then readArrayInReverse now because you've reached the last node in the array
				if targetPositions[currentTargetNode+1] == null:
					# if loop movement go to the first node
					if loopMovement:
						currentTargetNode = 0
						target_position = targetPositions[currentTargetNode].global_position
					# if not loop movement reverse movement
					if !loopMovement:
						#print("Next node is null, reverse reverse")
						currentTargetNode -= 1
						target_position = targetPositions[currentTargetNode].global_position
						readArrayInReverse = true
				elif targetPositions[currentTargetNode+1] != null:
					#print("Business as usual, read next node forwards")
					currentTargetNode += 1
					target_position = targetPositions[currentTargetNode].global_position
	if readArrayInReverse:	
		#print("Read array in reverse")
		# if the platform has reached its target position
		# move to the next target position
		if global_position == target_position:
			# if you've reached the first node in the array and you're moving backwards, 
			# count up to go to next node to move forwards
			if currentTargetNode == 0:
				#print("Reached first node in array, forward march")
				currentTargetNode += 1
				target_position = targetPositions[currentTargetNode].global_position
				readArrayInReverse = false
			else:
				#print("Business as usual, read next node in reverse")
				currentTargetNode -= 1
				target_position = targetPositions[currentTargetNode].global_position
