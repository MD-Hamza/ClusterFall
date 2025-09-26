extends Node2D

@export var spacing: float = 120.0
@export var tween_time: float = 0.5

var projectile_scene: PackedScene = preload("res://Projectile/projectile.tscn")
var projectiles: Array = []
var final_pos: Vector2 = Vector2(500, 300)
var prevPlayerPosition: Vector2


func _process(delta):
	var player = get_tree().get_nodes_in_group("Player")[0]
	if (!projectiles.is_empty()):
		for p in projectiles:
			var playerdelta = player.position - prevPlayerPosition;
			p.position += playerdelta;
		
	if Input.is_action_just_pressed("shoot"):
		spawn_projectiles(player.position);
	
	if Input.is_action_just_released("shoot"):
		final_pos = player.position + Vector2(250, 0);
		for p in projectiles:
			if p and p.is_inside_tree():
				var tween := create_tween()
				tween.tween_property(p, "position", final_pos, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

		projectiles.clear()
	prevPlayerPosition = player.position;
	
func spawn_projectiles(player: Vector2):
	var num_projectiles = 5
	var middle_index = num_projectiles / 2

	for i in range(num_projectiles):
		var projectile = projectile_scene.instantiate()
		add_child(projectile)
		projectiles.append(projectile);
		
		# Start all projectiles at the middle projectile position
		var start_pos = player
		projectile.position = start_pos

		# Target vertical offset relative to middle projectile
		var y_offset = (i - middle_index) * spacing
		var target_pos = Vector2(150, y_offset) + player;
		
		# Tween to the target position
		var tween := create_tween()
		tween.tween_property(projectile, "position", target_pos, tween_time).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
