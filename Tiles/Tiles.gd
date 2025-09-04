extends Node2D

@onready var sprite = $Sprite2D
var is_falling = false
var is_shaking = false

func _on_body_entered(body):
	if body.is_in_group("player") and not is_falling:
		if not is_shaking:
			is_shaking = true
			shake_and_fall(body)

# Shakes, then drops
func shake_and_fall(player):
	# Shake animation
	var tween = create_tween()
	tween.tween_property(self, "position:x", position.x + 5, 0.1).as_relative()
	tween.tween_property(self, "position:x", position.x - 10, 0.1).as_relative()
	tween.tween_property(self, "position:x", position.x + 5, 0.1).as_relative()

	await tween.finished

	# After shaking, drop down
	is_falling = true
	var fall_tween = create_tween()
	fall_tween.tween_property(self, "position:y", position.y + 300, 1.5)

	# If player is still colliding, drag it down
	while is_falling and player and player.get_overlapping_bodies().has(self):
		player.position.y += 3
		await get_tree().process_frame

	queue_free()
