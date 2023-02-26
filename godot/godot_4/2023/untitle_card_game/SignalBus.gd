extends Node

## Battle signals
signal battle_start_against(target)
signal battle_finished()


## Card Game signals
signal turn_ended_by(entity: CharacterEntity)
signal player_turn()
signal enemty_turn()
signal selected_card_data(card: CardBase)
