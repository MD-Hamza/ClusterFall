extends Node2D

@export var spacing: float = 120.0
@export var tween_time: float = 0.5

var projectile_scene: PackedScene = preload("res://Projectile/projectile.tscn")


func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		var player = get_tree().get_nodes_in_group("Player")[0]
		spawn_projectiles(player.position);
			
func spawn_projectiles(point: Vector2):
	var num_projectiles = 5
	var middle_index = num_projectiles / 2

	for i in range(num_projectiles):
		var projectile = projectile_scene.instantiate()
		add_child(projectile)

		# Start all projectiles at the middle projectile position
		var start_pos = point
		projectile.position = start_pos

		# Target vertical offset relative to middle projectile
		var y_offset = (i - middle_index) * spacing
		var target_pos = point + Vector2(150, y_offset)

		# Tween to the target position
		var tween := create_tween()
		tween.tween_property(projectile, "position", target_pos, tween_time).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
