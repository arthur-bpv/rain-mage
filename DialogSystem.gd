extends Control

var qeue = [
	'Olá player, vejo que está de passagem!',
	'Cuidado com os penhascos...',
	'Não diga que eu não avisei...'
]
var isDialoguing = false
var currentLine = 0

func _ready():
	$Label.visible = false

func start_dialog():
	$Label.visible = true
	$Label.text = qeue[currentLine]

func next_line():
	if currentLine < qeue.size() - 1:
		currentLine += 1
		$Label.text = qeue[currentLine]
	else:
		end_dialog()

func end_dialog():
	$Label.visible = false
	currentLine = 0

func _input(event):
	if event.is_action_pressed("interact"):
		if $Label.visible:
			next_line()
		else:
			start_dialog()
