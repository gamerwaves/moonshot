extends Node

var starCountdown := 5
var starCompleted := false

func collectStar():
	starCountdown -= 1
	if starCountdown == 0:
		resetStars()
func resetStars():
	starCountdown = 5
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	starCompleted = true

@onready var music_player := AudioStreamPlayer.new()

func playAudio():
	add_child(music_player)
	music_player.stream = preload("res://resources/ost.wav")
	music_player.play()
