extends Node

enum Items {DEFAULT, FLASHLIGHT, BALLOON}

var balloon_unlocked = false :
    set (value):
        balloon_unlocked = value
    get:
        return balloon_unlocked

var flashlight_unlocked = false :
    set (value):
        flashlight_unlocked = value
    get:
        return flashlight_unlocked

var pencil = false  #don't have a use for this yet?
var fishing_pole = false

var hide_labels = false
var hide_item_viewer = true

# Quest variables
var clues = 0
var total_clues = 8

# Maze ghost quests
var ghost_hunt_started = false
var pinky = false
var inky  = false
var sue = false
var clyde = false

# Fishing ghost quest
var fishing_quest_completed = false


func increment_clues():
    clues = clues + 1
    pass
