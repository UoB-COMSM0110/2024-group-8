
![image](https://github.com/UoB-COMSM0110/2024-group-8/blob/main/images/banner.png?raw=true)

### <i>Doctor! We need YOUR help! Protect the body’s immune system from invaders by placing and upgrading towers to fight back against infection. Use your intuition and skill to race against the clock and protect the host. It’s up to YOU to save our patient… time is ticking…</i>

Immune System Defense is a fun and engaging game for children aged 9-14 - accessible to beginners but also providing a challenge for those more experienced. Based upon the classic style of Tower-Defense games, it combines strategy and action with  a link to the human body and some of its defence mechanisms. Players buy and place towers which attempt to attack, or slow down invaders. Make it to the end of the rounds without losing all your lives to win.

[Click here to watch Immune System Defense: The Trailer.](https://www.youtube.com/watch?v=dQw4w9WgXcQ)


## Table of Contents
- [Team](#team)
- [Introduction](#introduction)
- [Kanban Board | Photo Album](#kanban-board--photo-album)
- [Immune System Defence](#immune-system-defence)
- [Requirements:](#requirements)
  - [Stakeholder:](#stakeholder)
  - [User Stories:](#user-stories)
  - [Use-case (player):](#use-case-player)
- [Design](#design)
- [Implementation](#implementation)
- [Evaluation](#evaluation)
- [Process](#process)
- [Conclusion](#conclusion)
- [Acknowledgements](#acknowledgements)


# Team

//TODO: ADD NAMES TO IMAGE. Ask Julia for website that font was made on.
![image](https://github.com/UoB-COMSM0110/2024-group-8/assets/117166891/c84a4952-3bef-4fa6-9d88-e8a353425535)
We are Group 8: Arielle, Julia, Isaac, Vincent and Alex.

# Introduction

Immune System Defense builds upon the classic style of Tower-Defense games, combining invader-germs with the quirks of the human body and its complex defence mechanisms that fight infection. As a team, we enjoyed exploring the parallels that could be drawn between the two and developed the game as a concept which is semi-educational, being somewhat informative about germ theory whilst remaining fun and fresh to the player.

///GIF OF GAMEPLAY///


Each environment (the brain, heart, lungs and kidney) features a different map and different environmental conditions. For example, within the heart the blood viscosity is varied from high to low as the game progresses, increasing the speed at which the viruses travel - making them much more difficult to kill. In the brain, the threat of an aneurysm leaves the player exposed to an explosive end to gameplay .

///confirm if correct////.


//Image of 4x4 each gameplay//


The player takes the opposing side: their goal is to kill the invaders before they make it to the end of their route (and therefore ‘enter’ into the rest of the body). By purchasing towers and placing them in optimal locations, a defensive map is built up. Provided with a limited amount of money (which only increases when enemies are killed), the player needs to form a strategy and optimise their approach for the best results. 

Do they buy more towers for greater coverage of the map, upgrade existing ones for greater attributes, or save up to buy something even more powerful in the next round?
From the winding pathways of the circulatory system to the confined spaces in the lungs - each scenario presents a different gameplay and as such requires strategic adaptation, becoming more and more of a challenge as the game progresses. Adapting to follow feedback during development, we feel the game is pitched at the right level for most participants - winning is possible but only with proper thought and consideration. 





# [Kanban Board](https://dramatic-clutch-d0e.notion.site/Group-8-Agile-Project-Management-bb06c2d090f543f9b2f2d0bc953f3d08) | [Photo Album](https://photos.app.goo.gl/bzxtsnzj8zHpwrJ6A)




 Human Body Tower Defence.
This game builds upon the widely popular Tower Defence style of game - where the aim is to protect a () from invaders. 
Using the human body as a thematic device, the game aims to provide some educational value in reinforcing the understanding of the body's mechanism to fight infection - whilst being fun and engaging for all ages. 

The novel aspects of this game are the ways in which interventions - either clinical or otherwise allow the user to influence in-game physics - from dieuretic tablets that increase the flow of invaders through the kidney, to smoke inhalation which weakens the health of enemies in the lungs.  




Prototype Video: https://github.com/UoB-COMSM0110/2024-group-8/blob/main/Paper_Prototyping/Idea_1_Paper_Prototyping.mp4

<img src="https://github.com/UoB-COMSM0110/2024-group-8/blob/main/images/Paper_Prototyping_with_overlay.gif?raw=true" width="400" />

# Immune System Defence
<table>
  <tr>
    <td>
      <!-- Your first block of text and image -->
      <strong>Select the map and the difficulty!</strong><br>
      <img src="https://github.com/UoB-COMSM0110/2024-group-8/blob/main/images/map&difficulty.gif?raw=true" width="300" />
    </td>
    <td>
      <!-- Your second block of text and image -->
      <strong>Explore the different towers and their properties!</strong><br>
      <img src="https://github.com/UoB-COMSM0110/2024-group-8/blob/main/images/towers.gif?raw=true" width="600" />
    </td>
  </tr>
</table>

<!-- Center-aligned table with borders in GitHub Markdown -->
<div align="center">

|                                   Place them strategically to defeat the enemies!                                   |
| :-----------------------------------------------------------------------------------------------------------------: |
| <img src="https://github.com/UoB-COMSM0110/2024-group-8/blob/main/images/defeatenemies.gif?raw=true" width="300" /> |

</div>

# Requirements:

In the early stages of designing "Human Body Tower Defence," our team started an extensive ideation process to determine the game's direction and features. We began by brainstorming ideas based on our collective interests and educational objectives. Through meetings, discussions and online research, we came up with the idea to incorporate educational themes of human anatomy with classic games of tower defence to create not only an entertaining game, but also educational.To further refine our ideas, we analysed competitor games, and asked for feedback from potential users. This process allowed us to evaluate the feasibility and potential impact of various concepts and make informed decisions about the game's direction. Ultimately, we decided as a team to develop a tower defence game centred around the human body, therefore creating an innovative and educational gaming experience that would resonate with our target audience of students, educators, and gamers alike. Through ongoing collaboration and feedback, we continue to refine and evolve our game concept, ensuring that it aligns with our goals and meets the needs of our stakeholders.
In crafting the early stages design for "Human Body Tower Defence," we utilised a comprehensive approach that incorporated use case diagrams and user stories to guide our ideation process.

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

User stories play a crucial role in the game development process as they serve as a bridge between stakeholders' needs and the implementation of game features. They provide a concise yet comprehensive description of the desired functionality from various perspectives, guiding the development team in understanding and prioritising requirements. In the context of our "Human Body Tower Defence" game, user stories like wanting to create an educational game popular among students, desiring competitive multiplayer functionality, aiming for innovative gameplay to attract players, influencing students to learn about the effects of germs on human organs, and ensuring all project requirements are met are invaluable. These user stories offer specific insights into the motivations and objectives of different stakeholders, allowing the team to tailor the game experience to meet their needs effectively. 

For this, we asked for different participants to try our then not-finished game and asked them to express their thoughts while playing our game. Simultaneously, we wrote down the key feedback ideas we were getting to further develop our game. For instance, the developer's goal of creating an educational game aligns with the teacher's objective of influencing students to engage with educational content, while the investor's desire for innovative gameplay ties into the player's interest in competitive multiplayer experiences.

> As the developer, I want to make an educational game that is popular among students, so that my game could have more exposure to the younger generation and I could earn more reputation in game industry.

> As the player, I want to play a tower defence game with another user, so that I can have a competition with my friends and have some fun.

> As the investor, I want to invest in the game development industry by developing an innovative game to attract more players, so that I can start earning money from that game.

> As the teachers, I want to influence my students to play an educational game, so that the student can learn more about the effect of germs on different organ on a human, 

> As the project manager, I want to ensure the game developed is meeting all the requirements, so that the project can be successful.

By incorporating these user stories into our development process, we ensure that our game not only meets stakeholder expectations but also delivers a compelling and meaningful experience to our target audience.

## Use-case (player):

Within the development process of "Human Body Tower Defence," the use case diagram provides a visual framework for understanding the player's journey through the game. The gameplay sequence begins with the player starting the game and selecting a map, crucial decisions that set the stage for their experience.The four different maps we decided to develop were journeys through the brain, lungs, heart, and kidneys. These parts of the human body are not only crucial for our functioning but also offer various aspects that we could include in our game, such as depicting smoke emanating from the lungs. Each level progresses dynamically as the system generates new challenges, with enemies spawning and traversing the screen. The player strategically places defensive units to protect towers, facing randomized attacks orchestrated by the system. Throughout this process, the system presents options for tower types and locations, guided by the player's decisions and resource management mechanics. 

This iterative cycle continues until the level's objectives are met or the player's lives are expended. These user interactions and system responses, as depicted in the use case diagram, are essential in understanding the flow of gameplay and ensuring that the game development aligns with stakeholder objectives and user expectations. Through the incorporation of user stories from various perspectives, such as the developer's aim for educational impact and the player's responses, we ensure that our game design remains focused on delivering a compelling and engaging experience that meets the needs of our target audience.

<img width="1199" alt="use-case" src="https://github.com/UoB-COMSM0110/2024-group-8/assets/150365540/20e3a851-e34f-4282-8676-5f56ff0f7fb1">

![image](https://github.com/UoB-COMSM0110/2024-group-8/blob/main/images/use-case-diagram.jpeg?raw=true)


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

# Design
The system architecture of a game developed by software engineers encompasses various components and layers that work together to deliver a cohesive and engaging gaming experience. It specifies the internal components that make up a computer system and describes how these are interconnected, how they interact with each other, and how they are managed. Ada computer science. (n.d.). Ada Computer Science. Class diagrams and behavioural diagrams play essential roles in specifying and visualising the system architecture of a game developed by software engineers.

![Class Diagram](https://github.com/UoB-COMSM0110/2024-group-8/blob/main/images/classdiagram.jpg?raw=true)

Our first line of action, before beginning to code any of the software, was to think about what exactly we wanted the base of our game to be; what objects, players, scenarios we wanted. For this, we began sketching a class diagram of our soon-to-be game. The class diagram served as a visual representation of these elements, illustrating their relationships, attributes, and behaviours. Each class in the diagram encapsulated specific functionalities and characteristics, defining the building blocks of our game's architecture.  Our class diagram meticulously outlined the key game entities essential for "Human Body Tower Defence," including Towers, Enemies, and Maps, among others. Each class encapsulated specific functionalities and attributes crucial for their respective roles within the game. For instance, the Towers class served as a base class from which different tower types were inherited. These tower types, such as Tower A or Tower B, inherited common functionalities while introducing unique characteristics.

Attributes of the Towers class included cost, damage, projectile type, and attack range, defining their behaviour and effectiveness in combat. Similarly, the Enemies class encompassed various enemy types, each with distinct behaviours and attributes tailored to challenge players in different scenarios. For example, enemies in the Heart level might exhibit varying speeds to simulate blood flow, with faster enemies representing thinner blood towards the end of the level, providing an additional challenge as players progress. Additionally, our class diagram accounted for the dynamic nature of game environments by including Maps as a fundamental component. Maps encapsulated terrain features, obstacles, and environmental effects that influenced gameplay dynamics and strategic decisions. For instance, in the Lung level, a unique twist was introduced where the screen gradually darkened to simulate the invasion of fog into the lungs, adding an extra layer of challenge and immersion for players.

# Implementation


# Evaluation
# Process
# Conclusion
# Acknowledgements





















///////////
Heuristic Evaluation
<img width="583" alt="Screenshot 2024-03-11 at 10 33 24" src="https://github.com/UoB-COMSM0110/2024-group-8/assets/150365540/66edb8c0-d064-4447-a1e7-f6150c74d147">

We received feedback from participants who took part in playing the game we had and recorded their suggestions and issues they encountered.

1. Player should be able to place towers whilst a round is in progress;
2. Interesting twist: random shortcuts will appear for germs to pass;
3. Some suggests that we can use towers to block germs' path;




System Usability Scale (SUS) Analysis

| Person | Level 1 | Level 2 |
| ------ | ------- | ------- |
| 1      | 70      | 76      |
| 2      | 85      | 81      |
| 3      | 72.5    | 70      |
| 4      | 85      | 81      |
| 5      | 67      | 69      |
| 6      | 85      | 85.5    |
| 7      | 90      | 92.5    |
| 8      | 75      | 72      |
| 9      | 76      | 74      |
| 10     | 71      | 71      |



W test statistic = 5.5;
Number of non-tied pairs (n) = 7;

<i>In our project, we've chosen to use the spelling 'defense' rather than the traditional British-English spelling of 'defence'. As the original 'bloons' game originated in the US and subsequent releases have kept this spelling, we felt it was best to use the americanised version, to stay in-keeping with the theme. </i>

