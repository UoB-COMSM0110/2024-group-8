# Group 8:
![image](https://github.com/UoB-COMSM0110/2024-group-8/assets/117166891/c84a4952-3bef-4fa6-9d88-e8a353425535)

# [Kanban Board](https://dramatic-clutch-d0e.notion.site/Group-8-Agile-Project-Management-bb06c2d090f543f9b2f2d0bc953f3d08) | [Photo Album](https://photos.app.goo.gl/bzxtsnzj8zHpwrJ6A)

# Idea 1: Tower Defence
https://github.com/UoB-COMSM0110/2024-group-8/blob/main/Paper_Prototyping/Idea_1_Paper_Prototyping.mp4
## Design Options:

1. **Human Body:** 
- Different maps are different body part, e.g., liver, heart, etc
- Attackers are germs attempting to penetrate the body
- Defenders are different antibodies, which have different properties, and can destroy different germs
2. **University Campus:**
- Different maps are different building of the university/different areas of the uni
- Lecturers are the defenders of the campus, fighting off attacking students

## **3 Challenges:**

1. **Multiplayer:** 
- Where one one person operates the defence, upgrading the defence towers
- Whilst one upgrades the attackers and launches attacks

2. **Randomised attack:** 
- Each round can have an increasing difficulty
- But each play the kind/number of different kinds of enemies dispatched is randomised at run-time, so that you don’t know which order of attacks to expect
- E.g., Some enemies have special exteriors which can only be penetrated by certain defenders, but this can appear for the first time between a range levels, so you gamble on when to make certain upgrades to your defence

3. **Twist:** 
- Based on the level of difficulty you have a different ‘margin of error’, e.g., on easy mode the disease won’t take over the body until 100 defenders get through, but on hard mode you only have 20 lives until the disease takes over.
- Once you start letting enemies through, the temperature begins to rise, and the enemies become more intense/powerful?
- Physics element of they gain new abilities defending on the temperature increase
- E.g., You can have a defender tower which destroys enemies by freezing them to death, but once the temperature begins to rise, this effect becomes void

# Idea 2: Arcade Side-scroller

The main idea of this suggestion is that there are defined ‘sites’ or ‘areas’ which have their own theme and specific adversary/ physics/ secret.

## Design Options:

1. **“Through the Ages”** 
- From single-cell organism, ancient societies, medieval times to present day (and beyond).
- Attackers specific to location/time and impact can vary on narrative of advanced weaponry
- Possibly no defenders - only the player.

2. **World Tour: Across different countries and cultures**
- Opportunity to highlight areas of cultural significance - could relate to UNESCO World Heritage list.
- Educational - connect to national curriculum?

## 3 Challenges:

1. **“Chance Card”**
introduces a behaviour that fundamentally alters the physics. 
- Challenge will be creating physics and other mechanisms that can apply at any time and affect gameplay to different extents depending on current theme.
- Set of 5-8 examples introduced at start of play to players with a range of actions (similar to Mario kart). e.g. gravity changes by 90 degrees or light only visible in immediate area, or slowing of villains etc.
- TWIST: Adversaries can also play chance cards at random/pre-determined intervals.

2. **Generative Element**
- Each round/area is generated within a certain set of parameters, so it is always pseudo-unique.
- Lots of testing required to ensure generation creates levels that are both playable/fun and also complex enough to be challenging.

3. **Combining sprites**
- Potential for vehicles or other transportation method that the player can enter & then gain new features like speed or protection (horses, boats, cars, spaceships etc).
- Relationship between those elements, how the additional physics items are implemented and designed.


# Requirement:
## Stakeholder:
- Developer
- Project Manager
- Player (child, teen, young adult, casual user…)
- Investor - institutional/ individual
- Teachers ( of user)
- Assessors/ Teaching staff

Extended:
- Educational Authorities 
- Government (inc. EU for GD-PR etc.)
- Regulator
- Advertiser (if relevant)
- Publisher
- Distributor
- Retailer
- IP Holder (if using specific assets or images/themes)

## User Stories:
- As the developer, I want to make an educational game that is popular among students, so that my game could have more exposure to the younger generation and I could earn more reputation in game industry.

- As the player, I want to play a tower defence game with another user, so that I can have a competition with my friends and have some fun.

- As the investor, I want to invest in the game development industry by developing an innovative game to attract more players, so that I can start earning money from that game.

- As the teachers, I want to influence my students to play an educational game, so that the student can learn more about the effect of germs on different organ on a human, 

- As the project manager, I want to ensure the game developed is meeting all the requirements, so that the project can be successful.

## Use-case (player):

<img width="1199" alt="use-case" src="https://github.com/UoB-COMSM0110/2024-group-8/assets/150365540/20e3a851-e34f-4282-8676-5f56ff0f7fb1">

- Player start the games
- Player choose which map to play

 In level #?
- System generates new level
- User waits for ‘enemies’ to spawn and move throughout screen
- User places units to protect towers. 
- System uses enemy sprites to attack players towers. Randomised attacks within set limits dependant on progress through game. 
- System presents options of tower to user and highlights areas where the towers can be places
- User selects type of towers and locations to place in.
- System decrements (money??) total i.e. reduces amount of towers that can be placed.
- User limited by this feature.

 ..Repeats until user lives are expended or no enemies left..

- Player reaches end of level and game ends
- System asks player for Name
- System checks database for existing name and if unique, stores score in database
- System presents high score to user.
- System exits


