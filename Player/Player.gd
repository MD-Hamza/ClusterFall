extends CharacterBody2D

@export var speed = 500
@export var half_height_offset = 16

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	velocity = input_vector.normalized() * speed
	
	move_and_slide()
	check_tiles_below()


func check_tiles_below():
	var space_state = get_world_2d().direct_space_state
	var from_pos = global_position
	var half_player = half_height_offset
	
	# Cast a rectangle below the player
	var box = RectangleShape2D.new()
	box.extents = Vector2(8, half_player)  # Half-width 8, half-height half_player
	
	var transform = Transform2D(0, from_pos + Vector2(0, half_player))

	# Create a PhysicsShapeQueryParameters2D object
	var shape_query = PhysicsShapeQueryParameters2D.new()
	shape_query.shape = box
	shape_query.transform = Transform2D(0, global_position + Vector2(0, half_player))
	shape_query.collision_mask = 1  # Layer mask of tiles

	# Perform intersection
	var result = space_state.intersect_shape(shape_query, 10)

	
	for hit in result:
		if hit.collider.has_method("on_player_stand"):
			hit.collider.on_player_stand()

