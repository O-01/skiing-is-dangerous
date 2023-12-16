extends Node

var score = 0

func increase_score():
	score += 10

func decrease_score():
	if score - 10 < 0:
		score = 0
	else:
		score -= 10
