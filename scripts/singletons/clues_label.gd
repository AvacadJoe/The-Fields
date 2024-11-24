extends RichTextLabel

func _process(delta):
    self.text = "[center]Clues "+str(GameManager.clues) + "/" + str(GameManager.total_clues) + "[/center]"
    pass
