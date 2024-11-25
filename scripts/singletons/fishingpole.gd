extends MeshInstance3D

func _process(delta):
    self.visible = GameManager.fishing_quest_completed
    pass
        
