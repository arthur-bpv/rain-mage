extends Area2D

var player;
var dialogue;
var active = 0;

func _ready():
	player = get_parent().get_node("Player")
	dialogue = get_parent().get_node("CanvasLayer/DialogueSystem");

func _input(event):
	if Input.is_action_just_pressed("interact") and overlaps_body(player) and not dialogue.visible and active == 0:
		dialogue.add("Hello, World!");
		dialogue.add("Hello, World! Again!");
		dialogue.start();
		active = 1;


func _on_body_exited(body):
	if body == player:
		active = 0;
