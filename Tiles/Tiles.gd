extends Area2D

@onready var sprite = $Sprite2D
var is_falling = false
var is_shaking = false

func _on_body_entered(body):
	print(body.name)
	if (body.name == "Player"):
		if not is_shaking:
			is_shaking = true
			shake_and_fall(body)

# Shakes, then drops
func shake_and_fall(player):
	# Shake animation
	#var tween = create_tween()
	#tween.tween_property(self, "position:x", position.x + 5, 0.1).as_relative()
	#tween.tween_property(self, "position:x", position.x - 10, 0.1).as_relative()
	#tween.tween_property(self, "position:x", position.x + 5, 0.1).as_relative()
#
	#await tween.finished

	# After shaking, drop down
	is_falling = true
	var fall_tween = create_tween()
	fall_tween.tween_property(self, "position:y", position.y + 1000, 1.5)
	
	await fall_tween.finished
	queue_free()
