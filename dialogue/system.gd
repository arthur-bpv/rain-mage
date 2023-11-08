extends Control

var queue = [];
var index = 0;

func _ready():
	visible = false;

func add(text: String):
	# adicionar o portrait depois!
	queue.append(text);

func start():
	visible = true;
	$Label.text = queue[index];

func end():
	visible = false;
	index = 0;
	queue = [];

func next():
	if index < queue.size() - 1:
		index += 1;
		$Label.text = queue[index];
		$AnimationPlayer.play("writer")
	else:
		end()

func _input(event):
	if event.is_action_pressed("interact") and visible:
		next();
