extends KinematicBody2D

const PARTICLES: PackedScene = preload("res://scenes/player/run_particles.tscn")
onready var animation: AnimationPlayer = get_node("anim")
onready var sprite: Sprite = get_node("Sprite")

var velocity: Vector2

export(int) var speed

func _physics_process(_delta: float) -> void:
	move()
	verify_direction()
	animate()


func move() -> void:
	var direction_vector: Vector2 = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()

	velocity = direction_vector * speed
	velocity = move_and_slide(velocity)

func animate() -> void:
	if velocity != Vector2.ZERO:
		animation.play("run")
	else:
		animation.play("idle")



func verify_direction() -> void:
	if velocity.x > 0:
		sprite.flip_h = false
	elif velocity.x < 0:
		sprite.flip_h = true


func instance_particles() -> void:
	var particle = PARTICLES.instance()
	get_tree().root.call_deferred("add_child", particle)
	particle.global_position = global_position + Vector2(0, 16)
	particle.play_particles()
