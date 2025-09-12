extends Area2D

@onready var sprite = $Sprite2D
var is_falling = false
var is_shaking = false
var player_on = false

func _on_body_entered(body):
	if (body.name == "Player"):
		player_on = true
		if not is_shaking:
			is_shaking = true
			shake_and_fall(body)
		
# Shakes, then drops
func shake_and_fall(player):
	# Shake animation
	var tween = create_tween()
	var original_x = position.x
	var distance = 10
	
	for i in range(5):
		position.x = original_x - distance
		await get_tree().create_timer(0.05).timeout
		position.x = original_x + distance
		await get_tree().create_timer(0.05).timeout
	position.x = original_x
	
	# After shaking, drop down
	is_falling = true
	var fall_tween = create_tween()
	fall_tween.tween_property(self, "position:y", position.y + 1000, 1.5)
	
	if (player_on):
		var player_fall = create_tween()
		player_fall.tween_property(player, "position:y", position.y + 1000, 1.5)
	await fall_tween.finished
	queue_free()


func _on_body_exited(body):
	if (body.name == "Player"):
		player_on = false
