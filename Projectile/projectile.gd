extends Area2D

enum State { EXPAND, WAITING, CONTRACT, DESTROY }
var current;

var start_pos;
var end_pos;

var timer = 0;
var shot_time = 0.4;

var player;
signal destroyed(position: Vector2)

# Called when the node enters the scene tree for the first time.
func _ready():
	current = State.EXPAND;

func set_trajectory(start, end, player):
	start_pos = start;
	end_pos = end;
	position = start_pos + player.position;
	self.player = player;

func converge(end):
	current = State.CONTRACT
	start_pos = position - player.position
	end_pos = end
	timer = 0
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (current == State.EXPAND or current == State.CONTRACT):
		timer += delta;
		position = lerp(start_pos, end_pos, timer / shot_time) + player.position;
		if (timer >= shot_time):
			current = State.WAITING if current == State.EXPAND else State.DESTROY
	elif (current == State.WAITING):
		position = end_pos + player.position;
	else:
		destroyed.emit(position);
		queue_free()
