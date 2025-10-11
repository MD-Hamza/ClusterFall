extends Node2D

@export var spacing: float = 120.0
@export var tween_time: float = 0.5

var projectile_scene: PackedScene = preload("res://Projectile/projectile.tscn")

var projectiles: Array = []
var starting: Array = []
var targets: Array = []

var shooting = false
var timer = 0;

func _process(delta):	
	projectiles = projectiles.filter(func(x): return x != null)
		
	if Input.is_action_just_pressed("shoot"):
		spawn_projectiles();
	
	if Input.is_action_just_released("shoot"):
		for p in projectiles:
			p.converge(Vector2(250, 0))
	
func spawn_projectiles():
	var num_projectiles = 5
	var middle_index = num_projectiles / 2

	for i in range(num_projectiles):
		# Target vertical offset relative to middle projectile
		var y_offset = (i - middle_index) * spacing
		var target_pos = Vector2(150, y_offset);
		
		var projectile = projectile_scene.instantiate()
		projectile.set_trajectory(Vector2.ZERO, target_pos, get_tree().get_nodes_in_group("Player")[0])
		
		add_child(projectile)
		projectiles.append(projectile);
