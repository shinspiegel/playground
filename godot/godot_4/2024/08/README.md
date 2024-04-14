# Summary 

- [Controls](#controls)
- [Main Character](#main-character)
- [Power ups](#power-ups)
- [Power Ups][(#power-ups)
- [Levels](#levels)
- [Enemies](#enemies)
- [Game Flow Overview](#game-flow-overview)
- [Game Story](#game-story)

# Controls

- [x] Define controls

## Joystick

- **Movement**: Left Stick or D-pad
- **Roll**: Circle
- **Jump**: Cross
- **Jab**: Square
- **Ranged Attack**: Hold R1/R2 (aim) and Release R1/R2 (shoot)
- **Create Block**: Triangle
- **Forward Dash**: L1/L2 

## Keyboard (All)

All mapped keys, to be used with Arrows or VIM movement or WASD.
For each specific keymaps there is a section for each how it's suggested to use.

- **Movement**: Arrows, HJKL (Vim), WASD
- **Jump**: Space, Up on movement
- **Roll**: C or P (qwerty or equivalent in other layouts)
- **Jab**: Z or I (qwerty or equivalent in other layouts)
- **Ranged Attack**: Hold Shift (aim) and release Shift (shoot)
- **Create Block**: X or O (qwerty or equivalent in other layouts)
- **Forward Dash**: V or U (qwerty or equivalent in other layouts) 

<small>Letter keys are position on the QUERTY, same position applies for other latouts</small>

### Keyboard (Arrows)

- **Movement**: Arrows
- **Jump**: Space, Arrow Up
- **Roll**: C
- **Jab**: Z
- **Ranged Attack**: Hold Shift (aim) and release Shift (shoot)
- **Create Block**: X
- **Forward Dash**: V

### Keyboard (VIM)

- **Movement**: HJKL
- **Jump**: Space, K
- **Roll**: C
- **Jab**: Z
- **Ranged Attack**: Hold Shift (aim) and release Shift (shoot)
- **Create Block**: X
- **Forward Dash**: V

### Keyboard (WASD)

- **Movement**: WASD
- **Jump**: Space, W
- **Roll**: P
- **Jab**: I
- **Ranged Attack**: Hold Shift (aim) and release Shift (shoot)
- **Create Block**: O
- **Forward Dash**: U

# Main Character

- Design
- [ ] Descriptions
- [ ] Design


- Artwork
- [ ] Idle (4 frames)
- [ ] Move / Run (8 frames)
- [ ] Jab (6 frames)
- [ ] Roll (6 frames)
- [ ] Jump / Falling (2 frames / 1 frame)
- [ ] Landing (4 frames)


- [ ] Arrow (1 frame)
	- [ ] Arrow extra damage (1 frame)
- [ ] Create block (4 frames)
	- [ ] More resistent (1 frame)
	- [ ] Damageable (1 frame)
- [ ] Forward dash (4 frames for starting, 2 frames for final)
	- [ ] Dash invulnerability (2 frames)
	- [ ] Dash damage (2 frames)


- Mechanics
- [ ] Coyote-time
- [ ] Jump buffer


<!-- TODO: Create description -->
<!-- TODO: Artwork -->
<!-- TODO: Extra gameplay mechanics -->


# Power Ups

## Ranged Attack

Can interact with distant objects

- Upgrades
	- [ ] Increase distance (whole screen) #Forest
	- [ ] Shoot increase damage (more than Jab) # Beach
	- [ ] Shot 3 projectiles #Vulcano


## Create Block

Can be place to move on it

- Upgrades
	- [ ] The block have extra life #Forest
	- [ ] Anything that damages the block recover your life #Beach
	- [ ] Can create two at the same time #Vuldano


## Forward Dash

Close gaps that jump can't

- Upgrades
	- [ ] Gain invulnerability on the dash #Forest
	- [ ] Deal damage on the path #Beach
	- [ ] Reduced colddown #Vulcano


# Levels

- [ ] Create base idea

## Sacret Deer Forest (Forest)

- [x] Story
- [x] Plan
- [ ] Tilemap
- [ ] Level design
- [ ] Enemies idea

In this sacret forest protected by humanity from the influence of the demon king.
Now felt in hands and the mind control of the demon king, needs to destroy his creatures and preseve the sacret deer.
Needs to destroy the mind-control device in the forest while hords of enemies appear.

- Power Ups Upgrades:
	- **Ranged Attack**: Increase Distance
	- **Create Block**: Extra life
	- **Forward Dash**: Forest


## Wave power generation (Beach)

- [x] Story
- [x] Plan
- [ ] Tilemap
- [ ] Level design
- [ ] Enemies idea

On the calm beachs the energy production is created from the water waves.
The demon king used his minions to convert the energy into his power to dominate the minds of his vassals.
Needs to remove the tendrils from the wave generators. Each generator is on a differnt part of the map.

- Power Ups Upgrades:
	- **Ranged Attack**: Shot increased damage
	- **Create Block**: Damage block recover life
	- **Forward Dash**: Deal damage on the path


## Vulcano Level (Vulcano)

- [ ] Story
- [ ] Plan
- [ ] Tilemap
- [ ] Level design
- [ ] Enemies idea

The biggest mountain in the whole region, it's a natural treasure and fear.
With the usage of the magic and techonology this vuldano mountain is kept under control.
The demon king is trying to make the vulcano to erupt for evildoing things.
Needs to collect batteries on the map and add on the eruption protection device.

- Power Ups Upgrades:
	- **Ranged Attack**: Shot 3 projectiles
	- **Create Block**: Create extra block
	- **Forward Dash**: Reduced colddown


## Demon King castle

- [ ] Story
- [ ] Tilemap
- [ ] Level design
- [ ] Enemies idea

<!-- TODO: Create description -->


# Enemies

- [ ] Design

- Walker (just walk from side to side and idle in between)
- Defender / Tank (holds something to protect, avoids damage)
- Shooter (does not move, shoot on invervals)
- Sniper (wanders, if player in sight, shoot)
- Medusa head (floats on screen, ignore tilemap)
- Hovering (hovers and drops bombs)


# Game Story

- [x] Story

The demon king stole the soul of alchemist wife and will use to make the human domination spell to have all the human as his slaves.
Use the present day setting for the scenario with mixture of fantastical and magical themes.
The demon king is the main character itself who went back in time to save his wife soul in the detriment of the city.


## Pitch Elevator

"In a world of magic and technology an alchemist needs to save his wife soul to prevent the demon king from enslave the whole humanity in this platformer action game"


# Game Flow Overwiew

- [x] Game flow

Alchemist needs to run over 3 levels to collect to solve problems on each area.
Every problem solved can acquire a power up.
On each level there is a pathway that can only be accesible with the usage of a alchemist power.

Last level should face a boss. 
On boss level should use all the collected alchemist power to complete the level.
The boss have 3 states, on each it's vulnerable to a single power usage.

