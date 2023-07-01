extends Node


## Battle signals
signal battle_start_against(target)
signal battle_finished()


## Card Game signals
signal turn_ended_by(entity: CharacterEntity)
signal player_turn()
signal enemty_turn()
signal selected_card_data(card: CardBase)
signal card_game_over()
signal card_game_won(target: CharacterEntity)
signal card_game_lost(target: CharacterEntity)


