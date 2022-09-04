extends Node

# Player
signal player_hp_changed(amount, max)

# State change signals
signal state_entered_for(target, state)
signal state_exited_for(target, state)

