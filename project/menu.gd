extends CanvasLayer

signal start

func prompt_blinker():
	#while !Input.is_action_pressed("start"):
	while $Title1.is_visible():
		$StartPrompt.show()
		$PromptTimer.start()
		await $PromptTimer.timeout
		$StartPrompt.hide()
		$PromptTimer.start()
		await $PromptTimer.timeout
	#start.emit()
