# Layout


<div hidden>
```
@startuml classList

Root -- SignalBus
Root -- StoryManager
Root -- BattleManager
Root -- LevelMap

LevelMap -- Player 
LevelMap -- Enemy
LevelMap -- BattleStartArea

Player -- Actor
Enemy -- Actor

Actor -- ActorData

@enduml
```
</div>

![](classList.svg)
