extends CanvasLayer

signal start

func prompt_blinker():
	while !Input.is_action_pressed("start"):
		$StartPrompt.show()
		$PromptTimer.start()
		await $PromptTimer.timeout
	$StartPrompt.hide()
	start.emit()
