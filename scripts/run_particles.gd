extends AnimatedSprite


func play_particles() -> void:
	play()


func on_animation_finished():
	queue_free()
