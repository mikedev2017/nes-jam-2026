extends CharacterBody2D

const SPEED = 300.0
@export var hurtbox: Area2D


func _ready() -> void:
	print("Witch has HP: ", hurtbox.health_points)


func _physics_process(delta: float) -> void:
	# Has velocity
	
	# Witch needs to have the following States
	## Wandering to look for Player
	## Chase when Player is within a radius
	## Dash_Attack when Player gets within a certain distance

	move_and_slide()


func _on_hurtbox_received_damage() -> void:
	print("New HP: ", hurtbox.health_points)


func _on_hurtbox_died() -> void:
	print("Witch died")
	queue_free()
