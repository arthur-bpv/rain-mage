extends Area2D

var player;
var dialogue;

func _ready():
	player = get_parent().get_node("Player")
	dialogue = get_parent().get_node("CanvasLayer/DialogueSystem");

func _input(event):
	if Input.is_action_just_pressed("interact") and overlaps_body(player) and not dialogue.visible:
		dialogue.add("Eu sou uma placa na beirada da montanha");
		dialogue.start();
