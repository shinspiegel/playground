# Game Design Elements

- [ ] [Game Design](#Game-Design)
  - [ ] [Story](#Story)
  - [ ] [Theme](#Theme)
  - [ ] [Topics to explore](#Topics-to-explore)
- [ ] [Player](#Player)
- [ ] [Level Design](#Level-Design) (up to 3 areas)
  - [ ] Ground?
  - [ ] Cavern?
  - [ ] Tower/Castle?
  - [ ] Ocean/Marine?
  - [ ] Sky/Flying?
- [ ] [Enemy Design](#Enemy-Design) (up to 5 + boss)
  - [ ] Basic
  - [ ] Strong (elite)
  - [ ] Flying enemy
  - [ ] Defender
  - [ ] Self-destroy
  - [ ] Trust and back (feint attack?)
  - [ ] Healer
  - [ ] Boss

# Assets to create

- [ ] **Game Assets**
  - [ ] **Graphics**
    - [ ] Tileset (one per area)
    - [ ] Player
    - [ ] Enemies (one per enemy)
    - [ ] Boss (Cheater? Cheated? @VAMPIRE itself?)
  - [ ] **Music**
    - [ ] One music per area
    - [ ] One music for the game start screen
    - [ ] One for the player death
    - [ ] One for the boss fight
    - [ ] One for the endgame
  - [ ] **Sound**
    - [ ] Sound for everything

# Other Game Elements

- [x] HitBox / HurtBox
- [x] State Manager

# Player

- [ ] **Player**
  - [ ] Refine the player controller
    - [x] Jump buffer
    - [x] Real coyote-time
    - [x] Fix dash + double-jump + jump glitch
    - [x] Cleaned code for checking how to change state
  - [ ] ~~Player mini-map~~
  - [x] Add basic animation
  - [x] Player State
    - [x] Base state (extend for enemies?)
    - [x] Idle
    - [x] Move
    - [x] Falling
    - [x] Jump
    - [x] Attack
  - [x] PowerUps (as resource?)
    - [x] Created initial resource
    - [x] Double-Jump
    - [x] Charge Attack (break blocks)
    - [x] Unblockable Attack (dash + attack)

## Game Design Elements

This will be described all the elements for the game.

### Game Design

Section dedicated to elaborate and create the elements for the game project.

#### Story

- @NAME was a small kid and fell in love with a vampire.
- @VAMPIRE broke up with @NAME and told him that will only date him if he became a monster
- @NAME need to find the PowerUP to become a monster and date @VAMPIRE
- The PowerUps comes from connection between the @NAME and @VAMPIRE
- The final boss is the @VAMPIRE, she had cheated @NAME and she is the monster
- the @NAME will never be the monster, he will never be able to cheat

- **Scenes**
  - Intro scene (the break up)
  - Reach tall jar in the kitchen (powerup / doublejump)
  - Strong hug (powerup / charge)
  - Kiss (powerup / unblockable)
  - Cheating scene (defeat boss)
  - Open talking (Ending scene)

#### Theme

- Love
- Cheating / Being cheated
- Soulmate
  - PowerUp comes from link between soul

#### Topics to explore

- Depression
  - Low life with small depressive phrases
  - How to deal with the depression?
- Find strength through overcome challenge
  - Hit on enemies create small bubble message with encouragement
  - Every power up will have a small scene to give a moral boost

### Level Design

What levels should create?
How they are connected?
What is the big map to develop?

### Enemy Design

Which enemies should be used?

- basic
- Strong (elite)
- Flying enemy
- Defender
- Self-destroy
- Trust and back (feint attack?)
- Healer

What is the basic pattern and idea behind the boss fight?

- Use the aggression system?
