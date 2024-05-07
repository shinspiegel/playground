# Summary 

- [Todo List](#todo-list)
- [Controls](#controls)
- [Main Character](#main-character)
- [Power ups](#power-ups)
- [Levels](#levels)
- [Enemies](#enemies)
- [Game Flow Overview](#game-flow-overview)
- [Game Story](#game-story)


# Todo List
- [x] Controls
	- [x] Clean up the controls, focus on WASD + options
- [x] Damageables
	- [x] Review critical damage
- [x] DamageNumbers
- [x] Level selection screen
- [x] Power Up Selection (Post level)
- [x] Base level ui
- [ ] Create hazard for rolling [NEXT:]
- Main Character
	- Artwork
		- [ ] Idle
		- [ ] Move / Rum
		- [ ] Jab (Air Jab)
		- [ ] Roll
		- [ ] Landing
		- [ ] Hit
		- [ ] Die
		- [ ] Ranged (Air Ranged)
		- [ ] Block
		- [ ] Dash
	- Mechanics
		- [x] Air Jab
		- [x] Air Ranged
		- [x] Jump buffer
		- [x] Coyote-time
		- [x] Mana sytem
			- [x] Rolling consume mana
		- [x] Health / damage
		- [x] Roll from Air
		- [ ] Create block from Air [NEXT:]
		- [ ] Create block on the character instead of ahead [NEXT:]
- Power Ups
	- [x] Ranged Attack
		- [ ] Increase speed #Forest
		- [ ] Shoot increase damage (more than Jab) # Beach
		- [ ] Shot 3 projectiles #Vulcano
	- [x] Create Block
		- [ ] The block have extra life #Forest
		- [ ] Anything that damages the block recover your life #Beach
		- [ ] Can create two at the same time #Vuldano
	- [x] Forward Dash
		- [ ] Gain invulnerability on the dash #Forest
		- [ ] Deal damage on the path #Beach
		- [ ] Reduced colddown #Vulcano
- Levels
	- [x] Game Camera
	- [x] Base level 
		- [x] Spawner with camera
	- [x] Level Segments
		- [x] Respawn on death
	- [x] Camera Shake
	- [x] Oneway block
	- [x] Parallax background
	- Forest
		- [x] Story
		- [x] Plan
		- [x] Base files
		- [ ] Tilemap
		- [ ] Level design
			- [x] Initial Design (5min map)
			- [ ] Add options to use the roll in phew places [NEXT:]
			- [ ] Remove cheap damage [NEXT:]
			- [ ] Upgrade Ranged (Speed)
			- [ ] Upgrade Create (Extra life?)
			- [ ] Upgrade Dash (Inv on Dash?)
		- [ ] Enemies idea
	- Beach
		- [x] Story
		- [x] Plan
		- [x] Base files
		- [ ] Tilemap
		- [ ] Level design
			- [ ] Initial Design (5min map)
			- [ ] Upgrade Ranged
			- [ ] Upgrade Create
			- [ ] Upgrade Dash
		- [ ] Enemies idea
	- Vuldano
		- [x] Story
		- [x] Plan
		- [x] Base files
		- [ ] Tilemap
		- [ ] Level design
			- [ ] Initial Design (5min map)
			- [ ] Upgrade Ranged
			- [ ] Upgrade Create
			- [ ] Upgrade Dash
		- [ ] Enemies idea
	- Castle
		- [ ] Story
		- [ ] Tilemap
		- [x] Base files
		- [ ] Level design
			- [ ] Initial Design (10min map)
			- [ ] Upgrade Ranged
			- [ ] Upgrade Create
			- [ ] Upgrade Dash
		- [ ] Enemies idea
- Enemies
	- [x] Walker (just walk from side to side and idle in between)
		- [ ] Reduce time for the explosion [NEXT:]
		- [ ] Use different sprite for it [NEXT:]
	- [x] Shooter (does not move, shoot on invervals)
		- [ ] Make the area for shooting level dependent [NEXT:]
		- [ ] Add a charge before the shooting [NEXT:]
	- [x] Defender / Tank (holds something to protect, avoids damage)
	- [ ] Sniper (wanders, if player in sight, shoot)
	- [ ] Medusa head (floats on screen, ignore tilemap)
	- [ ] Hovering (hovers and drops bombs)
- Hazards
	- [ ] Spike (ground damage)
	- [ ] Moving platform
	- [ ] Mana hurt
	- [ ] Vertical Laser [NEXT:]
- Pickables
	- [ ] Heart Recover
	- [ ] Mana Recover
- [x] Game Story
- [x] Game flow


## Late Todo List

- [ ] Particles?
- [ ] Camera ritcule?
- [ ] Cutscenes?
- [ ] Rolling credits?
- [ ] Automate credits from CREDITS file?


# Controls

## Joystick

- **Movement**: Left Stick or D-pad
- **Roll**: Circle
- **Jump**: Cross
- **Jab**: Square
- **Ranged Attack**: R1/L2
- **Create Block**: Triangle
- **Forward Dash**: L1/L2 

## Keyboard (All)

All mapped keys, to be used with Arrows or VIM movement or WASD.

- **Movement**: Arrows or WASD
- **Jump**: Up or J
- **Roll**: K
- **Jab**: U
- **Ranged Attack**: I
- **Create Block**: Y
- **Forward Dash**: H

<small>Letter keys are position on the QUERTY, same position applies for other latouts</small>

# Main Character

[TODO: Create description]
[TODO: Artwork]
[TODO: Extra gameplay mechanics]

## Jump buffer

- Basic jump buffer

## Coyote-time

- Real coyote time
- Very little time (0.1s ?)

## Mana System

- Starts with 3 segment
- Player will have segments of mana to use
- The segments fill overtime and you have a maximum amount
- Every stage will have a increase segment of mana
- Start a level with full mana

## Health / damage

- Int value, starting with 50?
- Use damage numbers, average damage should be 10 (maybe 5 hit to die)
	- Big damage should be 25
	- Small damage should be 5
- Each level have a health upgrade
- Each level will have 3 recovery items
- Damage does not recover across levels


# Power Ups

- Each power up consumes a mana segment
- No power up should consume more than a single segments

## Ranged Attack

Can interact with distant objects

- Upgrades
	- Increase distance (whole screen) #Forest
	- Shoot increase damage (more than Jab) # Beach
	- Shot 3 projectiles #Vulcano


## Create Block

Can be place to move on it

- Upgrades
	- The block have extra life #Forest
	- Anything that damages the block recover your life #Beach
	- Can create two at the same time #Vuldano


## Forward Dash

Close gaps that jump can't

- Upgrades
	- Gain invulnerability on the dash #Forest
	- Deal damage on the path #Beach
	- Reduced colddown #Vulcano

# Levels

## Sacret Deer Forest (Forest)

In this sacret forest protected by humanity from the influence of the demon king.
Now felt in hands and the mind control of the demon king, needs to destroy his creatures and preseve the sacret deer.
Needs to destroy the mind-control device in the forest while hords of enemies appear.

- Power Ups Upgrades:
	- **Ranged Attack**: Increase Distance
	- **Create Block**: Extra life
	- **Forward Dash**: Forest


## Wave power generation (Beach)

On the calm beachs the energy production is created from the water waves.
The demon king used his minions to convert the energy into his power to dominate the minds of his vassals.
Needs to remove the tendrils from the wave generators. Each generator is on a differnt part of the map.

- Power Ups Upgrades:
	- **Ranged Attack**: Shot increased damage
	- **Create Block**: Damage block recover life
	- **Forward Dash**: Deal damage on the path


## Vulcano Level (Vulcano)

The biggest mountain in the whole region, it's a natural treasure and fear.
With the usage of the magic and techonology this vuldano mountain is kept under control.
The demon king is trying to make the vulcano to erupt for evildoing things.
Needs to collect batteries on the map and add on the eruption protection device.

- Power Ups Upgrades:
	- **Ranged Attack**: Shot 3 projectiles
	- **Create Block**: Create extra block
	- **Forward Dash**: Reduced colddown


## Demon King castle (Castle)

<!-- TODO: Create description -->


# Enemies

- Walker (just walk from side to side and idle in between)
- Defender / Tank (holds something to protect, avoids damage)
- Shooter (does not move, shoot on invervals)
- Sniper (wanders, if player in sight, shoot)
- Medusa head (floats on screen, ignore tilemap)
- Hovering (hovers and drops bombs)


# Game Story

The demon king stole the soul of alchemist wife and will use to make the human domination spell to have all the human as his slaves.
Use the present day setting for the scenario with mixture of fantastical and magical themes.
The demon king is the main character itself who went back in time to save his wife soul in the detriment of the city.


## Pitch Elevator

"In a world of magic and technology an alchemist needs to save his wife soul to prevent the demon king from enslave the whole humanity in this platformer action game"


# Game Flow Overwiew

Alchemist needs to run over 3 levels to collect to solve problems on each area.
Every problem solved can acquire a power up.
On each level there is a pathway that can only be accesible with the usage of a alchemist power.

Last level should face a boss. 
On boss level should use all the collected alchemist power to complete the level.
The boss have 3 states, on each it's vulnerable to a single power usage.

