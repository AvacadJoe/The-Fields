extends RichTextLabel

func _process(delta):
    self.visible = GameManager.clues_visible
    self.text = "[center]Clues "+str(GameManager.clues) + "/" + str(GameManager.total_clues) + "[/center]"
    pass
