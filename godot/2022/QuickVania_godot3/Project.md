# Game Design Elements

- [ ] [Game Design](#Game-Design)
  - [ ] [Story](#Story)
  - [ ] [Theme](#Theme)
  - [ ] [Topics to explore](#Topics-to-explore)
- [x] [Player](#Player)
- [ ] [Level Design](#Level-Design) (up to 3 areas)
  - [x] Base Level scene
  - [x] Room Area
  - [ ] Levels
    - [ ] Bedroom (own house)
    - [ ] Kitchen (double-jump)
    - [ ] Outdoor Park (charge/breakable)
    - [ ] Grocery shop (dash)
    - [ ] Dark Castle
- [ ] [Enemy Design](#Enemy-Design) (up to 5 + boss)
  - [ ] Enemies
    - [x] Base enemy scene
    - [x] Pink/Heart blob
    - [ ] Flog-like
    - [ ] Fire blob
    - [ ] Handsome shade-guy
    - [ ] Strong shade-guy
    - [ ] Floating head
  - [ ] Hazards
    - [ ] Ground spikes
      - [ ] Heart version
      - [ ] Black version
    - [ ] Trapdoor platform
    - [ ] Moving platform
    - [ ] Breakable wall
  - [ ] Boss @VAMPIRE shade
- [ ] Other Entities
  - [x] HitBox / HurtBox

# Managers

- [x] **Managers**
  - [x] Game Manager
  - [x] Level Manager
  - [x] Screen Manager
  - [x] State Manager
  - [x] Bubble Message Manager

# Assets to create

- [ ] **Game Assets**
  - [ ] **Graphics**
    - [ ] Tileset (one per area)
      - [ ] Bedroom (own house)
      - [ ] Kitchen (double-jump)
      - [ ] Outdoor Park (charge/breakable)
      - [ ] Grocery shop (dash)
      - [ ] Dark Castle
    - [ ] Player
    - [ ] Enemies (one per enemy)
    - [ ] Boss
  - [ ] **Music**
    - [ ] One music per area
      - [ ] Bedroom (own house)
      - [ ] Kitchen (double-jump)
      - [ ] Outdoor Park (charge/breakable)
      - [ ] Grocery shop (dash)
      - [ ] Dark Castle
    - [ ] One music for the game start screen
    - [ ] One for the player death
    - [ ] One for the boss fight
    - [ ] One for the endgame
  - [ ] **Sound**
    - [ ] Sound for everything
      - [ ] Player
        - [ ] One per state?
        - [ ] Death?
        - [ ] Extra sounds

# Player

- [x] **Player**
  - [x] Refine the player controller
    - [x] Jump buffer
    - [x] Real coyote-time
    - [x] Fix dash + double-jump + jump glitch
    - [x] Cleaned code for checking how to change state
  - [ ] ~~Player mini-map~~
  - [x] Add basic animation
	- [x] Speak message bubble
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

- @HERO was a small boy and fell in love with a vampire.
- @VAMPIRE broke up with @HERO and told him that will only date him if he became a monster
- @HERO need to find the PowerUP to become a monster and date @VAMPIRE
- The PowerUps comes from connection between the @HERO and @VAMPIRE
- The final boss is the @VAMPIRE, she had cheated @HERO and she is the monster
- the @HERO will never be the monster, he will never be able to cheat

- **Scenes**
  - Intro scene (the break up)
  - Reach tall jar in the kitchen (powerup / doublejump)
  - Strong hug after death of mother in the park (powerup / charge)
  - Kiss in the grocery shop to protect him from ex-girl (powerup / dash to avoid)
  - Cheating scene with shadow guy (defeat boss)
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

- [ ] Intro level, inside house (scene)
  - Heart Blob enemy
  - Spikes
  - Trapdoor platform
- [ ] Kitchen theme (double-jump)
  - Blob enemy
  - Frog-like enemy
- [ ] Outdoors park (breakable object)
  - Fire Blob enemy
  - holes in the ground (death pit)
  - Moving platform
  - Breakable walls
- [ ] Grocery shop (dash)
  - Handsome shade-guy
  - Breakable walls
  - Moving platform
- [ ] Dark castle
  - Strong shade-guy with protection
  - Floating @VAMPIRE heads pushing back
  - breakable walls
  - moving platforms
  - holes in the ground (death pit)
- [ ] Boss arena
  - Boss fight

### Enemy Design

Which enemies should be used?

- [ ] **Pink/Heart Blob** enemy
  - Explode in hearts
  - One-hit kill
- [ ] **Ground spikes** (heart themed)
  - easy to avoid
  - heart themed
  - heart with spike?
  - should hint the cheating from @VAMPIRE after get hit from this
- [ ] **Trapdoor platform**
  - with timer or open and fall
  - move, not break
  - should hint cheating from @VAMPIRE after falling
- [ ] **Frog-like** enemy
  - heart themed
  - jump with the player
  - two-hit kill
- [ ] **Fire Blob** enemy
  - leave fire on the ground
  - one-hit kill
  - trails or heat and pain
- [ ] **Moving platform**
  - make customizable path for the platform
  - hard to reach messages
- [ ] **Breakable wall**
  - one-charge to break
  - immune to normal attacks
  - need to fit all the tiles
  - should add on other maps to extra rewards
  - "I need to find out what is beyond this wall"
  - message to encourage discovery
- [ ] **Handsome shade-guy**
  - five-hit or one-charge to kill
  - they should have happy bubble messages
  - should hint the cheating from @VAMPIRE
- [ ] **Strong shade-guy**
  - should have some kind of protection
  - shout insults ("You are not for her!", "she deservers better!")
  - five-hit, three-dash or one-charge to kill
- [ ] **Floating @VAMPIRE head**
  - Move and accelerate towards the @HERO
  - Scream "go away", "you should be better"
  - one-hit kill
  - one-dash kill
- [ ] **Boss @VAMPIRE in shade-form**
  - ten-hit, eight-dash or three-charge to kill
  - at least five pattern attacks
    - one attack to evade with the dash
    - one strong attack to heavy hit and telegraph
    - quick, low recovery attack
