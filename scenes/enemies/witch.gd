extends CharacterBody2D


const SPEED = 300.0


func _physics_process(delta: float) -> void:
	# Has velocity
	
	# Witch needs to have the following States
	## Wandering to look for Player
	## Chase when Player is within a radius
	## Dash_Attack when Player gets within a certain distance

	move_and_slide()
