
![image](https://github.com/UoB-COMSM0110/2024-group-8/blob/main/images/banner.png?raw=true)

### <i>Doctor! We need YOUR help! Protect the body’s immune system from invaders by placing and upgrading towers to fight back against infection. Use your intuition and skill to race against the clock and protect the host. It’s up to YOU to save our patient… time is ticking…</i>

Immune System Defense is a fun and engaging game for children aged 9-14 - accessible to beginners but also providing a challenge for those more experienced. Based upon the classic style of Tower-Defense games, it combines strategy and action with  a link to the human body and some of its defence mechanisms. Players buy and place towers which attempt to attack, or slow down invaders. Make it to the end of the rounds without losing all your lives to win.

[Click here to watch Immune System Defense: The Trailer.](https://www.youtube.com/watch?v=q7RNKd36_gA)


### Contents
- [Team](#team)
- [Immune System Defence](#immune-system-defence)
- [Introduction](#introduction)
- [Requirements](#requirements)
    - [User Stories](#user-stories)
      - [A selection of user stories:](#a-selection-of-user-stories)
      - [Use-cases](#use-cases)
- [Design](#design)
    - [Visual Design](#visual-design)
- [Implementation](#implementation)
- [Evaluation](#evaluation)
- [Process](#process)
- [Kanban Board | Photo Album](#kanban-board--photo-album)
- [Conclusion](#conclusion)
- [Acknowledgements](#acknowledgements)


# Team
<img src="https://github.com/UoB-COMSM0110/2024-group-8/blob/220b75c5d388dc2bd0439f8ea2c552d8882b3e9f/images/team_8_with_names.png" width="600" />
[ Figure X: Group 8 Photo ]<br><br>


<table align="center">
  <thead>
    <tr>
      <th style="text-align:center">Name</th>
      <th style="text-align:center">Email</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td style="text-align:center">Arielle Thijssen</td>
      <td style="text-align:center"><a href="mailto:cc20357@bristol.ac.uk">cc20357@bristol.ac.uk</a></td>
    </tr>
    <tr>
      <td style="text-align:center">Julia Alvarado Rubio</td>
      <td style="text-align:center"><a href="mailto:if19426@bristol.ac.uk">if19426@bristol.ac.uk</a></td>
    </tr>
    <tr>
      <td style="text-align:center">Kai Chun Cheung</td>
      <td style="text-align:center"><a href="mailto:xz23031@bristol.ac.uk">xz23031@bristol.ac.uk</a></td>
    </tr>
    <tr>
      <td style="text-align:center">Vincent Yaoyang Xu</td>
      <td style="text-align:center"><a href="mailto:uv23869@bristol.ac.uk">uv23869@bristol.ac.uk</a></td>
    </tr>
    <tr>
      <td style="text-align:center">Alexander Robinson</td>
      <td style="text-align:center"><a href="mailto:xk23756@bristol.ac.uk">xk23756@bristol.ac.uk</a></td>
    </tr>
  </tbody>
</table>

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

# Introduction

Immune System Defense builds upon the classic style of Tower-Defense games, combining invader-germs with the quirks of the human body and its complex defence mechanisms that fight infection. As a team, we enjoyed exploring the parallels that could be drawn between the two and developed the game as a concept which is semi-educational, being somewhat informative about germ theory whilst remaining fun and fresh to the player.

Each environment (the brain, heart, lungs and kidney) features a different map and different environmental conditions. For example, within the heart the blood viscosity is varied from high to low as the game progresses, increasing the speed at which the viruses travel - making them much more difficult to kill. In the brain, the threat of an aneurysm leaves the player exposed to an explosive end to gameplay .

<table>
  <tr>
    <td><img src="https://github.com/UoB-COMSM0110/2024-group-8/blob/main/images/brainmap.png?raw=true" alt="Image 1"></td>
    <td><img src="https://github.com/UoB-COMSM0110/2024-group-8/blob/main/images/heartmap.png?raw=true" alt="Image 2"></td>
  </tr>
</table>
<table>
  <tr>
    <td><img src="https://github.com/UoB-COMSM0110/2024-group-8/blob/main/images/kidneymap.png?raw=true" alt="Image 1"></td>
    <td><img src="https://github.com/UoB-COMSM0110/2024-group-8/blob/main/images/lungsmap.png?raw=true" alt="Image 2"></td>
  </tr>
</table>

The player takes the opposing side: their goal is to kill the invaders before they make it to the end of their route (and therefore ‘enter’ into the rest of the body). By purchasing towers and placing them in optimal locations, a defensive map is built up. Provided with a limited amount of money (which only increases when enemies are killed), the player needs to form a strategy and optimise their approach for the best results. 

<img src="https://github.com/UoB-COMSM0110/2024-group-8/blob/main/images/towers.gif?raw=true" width="600" />
[ Figure X: Overview of 'Tower' variants ]<br><br>


Do they buy more towers for greater coverage of the map, upgrade existing ones for greater attributes, or save up to buy something even more powerful in the next round?
From the winding pathways of the circulatory system to the confined spaces in the lungs - each scenario presents a different gameplay and as such requires strategic adaptation, becoming more and more of a challenge as the game progresses. Adapting to follow feedback during development, we feel the game is pitched at the right level for most of our target audience - winning is achievable with proper thought and consideration. 


# Requirements

In the early stages of “Immune System Defense”, the group spent time researching what already exists (and playing a good number of different games). We became interested in developing a game with an educational concept - one that could be light-hearted, but still inform and help children develop understanding of important concepts.

As outlined in detail in our [DesignOptions](Documents/DesignOptions.md) document, we created two proposals with a prototype of each game.

1) A Tower Defense game (in the style of Bloons <LINK>) where the player journeys through the Human Body and protects it from invading germs.
   [Prototype 1](https://github.com/UoB-COMSM0110/2024-group-8/blob/515eef5207a725f6a846677a536173a56bfc6542/Paper_Prototyping/Idea_1_Paper_Prototyping.mp4)
   
2) An Arcade side-scroller where the player travels through time from the dawn of humanity to the modern day. [Prototype 2](https://github.com/UoB-COMSM0110/2024-group-8/blob/515eef5207a725f6a846677a536173a56bfc6542/Paper_Prototyping/idea2.mp4) </br></br>
  

    
<img src="https://github.com/UoB-COMSM0110/2024-group-8/blob/main/images/Paper_Prototyping_with_overlay.gif?raw=true" width="600" /><br>
[ Figure X - Protype 1 "Human Body Defense" ]<br><br>

We took time to think about the direction we wanted to explore. Ultimately, after discussing our ideas and having our peers simulate ‘playing’ the paper-prototypes, we decided as a team to develop a tower defence game centred around the human body. The idea was further refined to align with our goals and the needs of our stakeholders, until we arrived at our final concept for ‘Immune System Defense’.
The educational objective of the game is to explain the overarching concepts of the [Germ Theory of Disease](https://en.wikipedia.org/wiki/Germ_theory_of_disease#:~:text=The%20germ%20theory%20of%20disease,animals%2C%20and%20other%20living%20hosts). <br><br>
By modelling infectious diseases as ‘germs’ who are independant life-forms that invade the body, we are teaching the notion that pathogens are agents of disease - and not going into too much detail so as to spoil the fun aspects of the game.
### User Stories
In crafting the early stages design for "Human Body Tower Defence," we utilised a comprehensive approach that incorporated use case diagrams and user stories to guide our ideation process.<br><br>
User stories play a crucial role in the game development process. They act as a bridge between stakeholders' needs and the implementation of game features. In the context of our game, user stories helped us to develop with a wide range of stakeholders in mind. As we chose to develop our game for children aged 9-14, reminding ourselves to regularly think as though we were those stakeholders helped to inform our game design.<br><br>
If the game is to be effective, it will need to be popular among school-age children. It will need to strike the right balance between *educational, but boring* and *fun, but without the opportunity to learn*.

Whilst exploring our prototype game, we asked a number of participants to think in the minds of their younger-selves and speak aloud their thoughts. Several useful comments have helped shape the functionality of the game, changing our approach.<br>

#### A selection of user stories:
> As the developer, I want to make an educational game that is popular among students, so that my game could have more exposure to the younger generation and I could earn more reputation in game industry.

> As the player, I want to play a tower defence game with another user, so that I can have a competition with my friends and have some fun.

> As the investor, I want to invest in the game development industry by developing an innovative game to attract more players, so that I can start earning money from that game.

> As the teachers, I want to influence my students to play an educational game, so that the student can learn more about the effect of germs on different organ on a human, 

> As the project manager, I want to ensure the game developed is meeting all the requirements, so that the project can be successful.



Many of these stories are interconnected. The developer's goal of creating an educational game aligns with the teacher's objective of influencing students to engage with educational content, while the investor's desire for innovative gameplay ties into the player's interest in competitive multiplayer experiences. 

#### Use-cases

![image](https://github.com/UoB-COMSM0110/2024-group-8/blob/14eae6550508dfedece6832377551c383a4d2dd4/images/use_case_diagram_b%26w.png)<br>
[Figure X - An example Use-case Diagram created at the start of development]<br><br>

Use-case diagrams provide a visual framework for understanding the player's journey through the game. In Figure X, the gameplay sequence begins with the player starting the game and selecting a map, a choice which will alter many features of the game-play (e.g. environmental conditions, type of enemy and general look and feel). Four different maps are available to choose: journeys through the brain, lungs, heart, and kidneys. These parts of the human body are not only crucial for our functioning but also offer various aspects that we could include in our game, such as depicting smoke emanating from the lungs. [Read about this Use-case in more depth.](https://github.com/UoB-COMSM0110/2024-group-8/blob/4455d5cc72482ded24f00e5d92964fe2df8ef78e/Documents/use_case.md)

Each level progresses dynamically as the system generates new challenges, with enemies spawning and traversing the screen. The player strategically places defensive units to attack the enemy, with the objective of maximising damage with minimal expenditure. 

![image](https://github.com/UoB-COMSM0110/2024-group-8/blob/85e3e4c7fc3b75109118b1c7180e39c246f5fe5e/images/use-case-diagram.jpeg)<br>
[Figure X - A use-case diagram showing UML with include and extend relationships]<br><br>

Throughout this process, the system presents options for tower types and locations, guided by the player's decisions and resource management mechanics. 
This iterative cycle continues until the level's objectives are met or the player's lives are expended. These user interactions and system responses (Figure X) are essential in understanding the flow of gameplay and ensuring that the game development aligns with stakeholder objectives and user expectations.

++ Do we need to add "Functional Requirements"?

# Design
System architecture describes how we use our software to achieve our goal of a playable game. In this section we discuss the underlying base code of our game and provide detail on several important classes and methods, along with their specific uses.

Our design process was primarily collaborative. Through discussion, we created an initial class diagram on paper, which then took over a near-by whiteboard. It was useful to talk though this process as a team - creating a visual representation of these elements, and discussing/debating how relationships, attributes, and behaviours should be interrelated.

![image](https://github.com/UoB-COMSM0110/2024-group-8/blob/85e3e4c7fc3b75109118b1c7180e39c246f5fe5e/images/developing_class_diagram_whiteboard.png)<br>
[ Figure X : Initial class diagram. Developing our game structure collaboratively ]<br><br>

The class diagram in Figure X outlines the key classes and entities required in “Immune System Defense”, including Towers, Enemies, and Maps, among others. Each class encapsulated specific functionalities and attributes crucial for their respective roles within the game. 

For instance, the Towers class served as a base class from which different tower types were inherited. These tower types, such as Tower A or Tower B, inherited common functionalities while introducing unique characteristics. Attributes of the Towers class included cost, damage, projectile type, and attack range, defining their behaviour and effectiveness in combat. 

Similarly, the Enemies class encompassed various enemy types, each with distinct behaviours and attributes tailored to challenge players in different scenarios. For example, enemies in the Heart level exhibit varying speeds to simulate blood flow, with enemies travelling faster through thinner blood as the body becomes weaker - providing an additional challenge as players progress. 

Additionally, our class diagram accounted for the dynamic nature of game environments by including Maps as a fundamental component. Maps encapsulated terrain features, obstacles, and environmental effects that influenced gameplay dynamics and strategic decisions. For instance, in the Lung level, a unique twist was introduced where the screen gradually darkened to simulate the invasion of fog into the lungs, adding an extra layer of challenge and immersion for players.

<img src="https://raw.githubusercontent.com/UoB-COMSM0110/2024-group-8/main/images/classdiagram.jpg" width="600" />
[ Figure X : Class Diagram, showing a simplified overview of the program structure. ]<br><br>

### Communication Diagram

Upon starting the coding part of a game, we also developed a comunication diagram that would help us visualize the interactions between objects and the different classes we may could want to develop later on.
By mapping these interactions, we were able to understand what type of actions each element, such as towers and enemies, needed.

<img src="https://github.com/UoB-COMSM0110/2024-group-8/blob/main/images/communicationdiagram.png?raw=true" />
[ Figure X : Communication Diagram, showing a different classes and methods we wanted to implement. ]<br><br>

<strong>Important classes and methods</strong>

<strong>[GameMap](https://github.com/UoB-COMSM0110/2024-group-8/blob/85e3e4c7fc3b75109118b1c7180e39c246f5fe5e/Prototype/GameMap.pde) class</strong>    
GameMap initialises and provides the ‘map’, the specific path on which the sprites will travel. 

<strong>[Round](https://github.com/UoB-COMSM0110/2024-group-8/blob/85e3e4c7fc3b75109118b1c7180e39c246f5fe5e/Prototype/Round.pde) class</strong> with <strong>[RunningGame](https://github.com/UoB-COMSM0110/2024-group-8/blob/85e3e4c7fc3b75109118b1c7180e39c246f5fe5e/Prototype/RunningGame.pde) class</strong><br>
These govern the ‘running’ of the specific level and the overall game. Between the two, a number of instance-specific variables govern how the round will run. <strong>RunningGame</strong> sits above Round, which combined with Round, keeps track of the user’s success (and failure) through the entire process.

in MapSelection, <strong>[handleMapSelection](https://github.com/UoB-COMSM0110/2024-group-8/blob/85e3e4c7fc3b75109118b1c7180e39c246f5fe5e/Prototype/MapSelection.pde) (PImage mapImage, int x, int y, int outlineSize, GameState state, GameMap map){ … </strong><br>
This command illustrates how the program passes information back and forth between classes. [GameState and GameMap](https://github.com/UoB-COMSM0110/2024-group-8/blob/85e3e4c7fc3b75109118b1c7180e39c246f5fe5e/Prototype/Prototype.pde) are enumerated types, passing just the information of what "type" the selection is, not the entire data.

<strong>[Heart](https://github.com/UoB-COMSM0110/2024-group-8/blob/85e3e4c7fc3b75109118b1c7180e39c246f5fe5e/Prototype/Heart.pde)</strong>, <strong>[Lung](https://github.com/UoB-COMSM0110/2024-group-8/blob/85e3e4c7fc3b75109118b1c7180e39c246f5fe5e/Prototype/Lung.pde)</strong>, <strong>[Kidney](https://github.com/UoB-COMSM0110/2024-group-8/blob/85e3e4c7fc3b75109118b1c7180e39c246f5fe5e/Prototype/Kidney.pde)... class</strong> extends GameMap.  
Specifics for each map are contained within child classes of GameMap. This avoids any kind of ‘config’ file that would be separate to the program. All initial game-state data is saved within Processing classes.

<strong>[Germ](https://github.com/UoB-COMSM0110/2024-group-8/blob/85e3e4c7fc3b75109118b1c7180e39c246f5fe5e/Prototype/Germ.pde) class</strong> with <strong>[GermSprite](https://github.com/UoB-COMSM0110/2024-group-8/blob/85e3e4c7fc3b75109118b1c7180e39c246f5fe5e/Prototype/GermSprite.pde) class</strong>   
This is the parent class for all instances of pathogen invader. Its constructor method is the superclass called when they are instantiated. GermSprite contains the image-handling logic for displaying the correct picture and its orientation for each instance.

<strong>[Cell](https://github.com/UoB-COMSM0110/2024-group-8/blob/dedbc5b92a19e8bddd87b5666a1e49cc7c7376d7/Prototype/Cell.pde) class</strong>  
With attribute ‘isPath’ and ‘buildable’. The cells divide the playable screen into a grid - which the user can select to place towers on. Its constructor method assigns it cartesian coordinates (x,y).

<strong>[DefenceTower](https://github.com/UoB-COMSM0110/2024-group-8/blob/dedbc5b92a19e8bddd87b5666a1e49cc7c7376d7/Prototype/DefenceTower.pde) abstract class</strong>  
The parent class for all of the towers. This provides the underlying functionality that can be extended for the specific cases.  

<strong>[TowerA](https://github.com/UoB-COMSM0110/2024-group-8/blob/dedbc5b92a19e8bddd87b5666a1e49cc7c7376d7/Prototype/TowerA.pde) extends [ShootingTower](https://github.com/UoB-COMSM0110/2024-group-8/blob/dedbc5b92a19e8bddd87b5666a1e49cc7c7376d7/Prototype/ShootingTower.pde)</strong>  
Here is an example of how inheritance of classes has helped the flexibility of the program.

```processing
protected TowerA(int x, int y, int sprite){
    super(x, y, sprite, "Basic Antibody", 0);
    // Array to hold the properties of an instance of TowerA, throught it's upgrade stages:
    this.properties = new int[][] {{ 75, 125, 200, 450 }, // Cost from intial to Upgrade 3
                      { 0, 0, 0, 2 }, // Projectile type
                      { 2, 2, 5, 7 }, // Damage Capability
                      { 1, 1, 1, 3 }, // Shots fired per second
                      { 2, 3, 3, 3 }  // Range
                }; 
      assignIntialProperties();
  } 

```
A generic tower DefenceTower is extended to form different objects for the user to place. One of these ‘ShootingTower’ emits projectiles which are aimed towards the enemies. Each projectile is a seperate instance of the <Strong>[Projectile](https://github.com/UoB-COMSM0110/2024-group-8/blob/dedbc5b92a19e8bddd87b5666a1e49cc7c7376d7/Prototype/Projectile.pde) class</strong>.

```processing
Class Projectile {
  float posX;
  float posY;
  int speed;
  PImage image;
  int damageCapability;
  Germ target;
  boolean onScreen = true;
  boolean targetAlive = true;
  ...

```
Some modelling is required for the projectile motion - both the sprite it is targeting and the projectile are moving - so their collision needs to be realistic, timely and accurate if it is to positively affect the game play. 

In <strong>[Heart](https://github.com/UoB-COMSM0110/2024-group-8/blob/dedbc5b92a19e8bddd87b5666a1e49cc7c7376d7/Prototype/Heart.pde) class</strong>, method <strong>decreaseBloodViscosity()</strong> is a good example of how using inherited classes for each of the levels allows specific physical properties to be substantially altered without disrupting the normal function of the parent class. There are similar adaptations across the other levels.

### Visual Design
Assets have come from a wide variety of places - some are retrieved from internet searches, others created by the team.  ////////TO DO: Slightly more text needed here/////

# Implementation 

Developing the logic of "Human Body Tower Defence" presented several challenges, particularly in integrating the rules of tower defense games with educational elements related to human anatomy and defense mechanisms.
Once we had an idea, we started developing the game. We were encouraged to use **Processing**, which is a very good tool for designing a visual program where coders can develop things that would appear on screen. However, Processing uses a version of the Java language, something we were not that familiar when we started with this project.
One of the primary hurdles was making ourselves comfortable with the Processing environment and its unique syntax. Transitioning to a new programming language and development environment required adapting our coding style and acquiring familiarity with Processing's syntax conventions. This involved grasping concepts such as defining classes, manipulating variables and functions, and discovering and using built-in libraries for graphical rendering and user interaction, all while simultaneously learning Java from scratch.
Furthermore, integrating complex functionalities like button animation, screen transitions, and dynamic element rendering introduced additional challenges. Despite these obstacles, we navigated the learning curve and very often revisited our previous code to make changes.

One of the first challenges we were presented with was deciding **what parts of the human body presented enough interesting aspects that we could incorporate into our game later on as twists**. For example, by incorporating the lung map we realised we could develop a teaching element about the concerns of smoking. We thought that the twist could be that the screen would be filled with smoke, making it harder to see the maps and the germs coming in. Besides implementing twists, we also had to consider which organs had suitable environmental conditions we could enhance in our maps to maintain the user's interest. Another example concerns the viscosity of blood, which we could adjust by slowing down the movement of germs.
After a day or so of thinking and each of us developing ideas; we ended up reuniting and choosing which four core organs would be interesting to implement and have an organ-related twist. These four were the heart; with a blood clot, the brain; with a brain stroke, the kidneys; with the kidney stone, and the lungs, with smoke filling up the lungs. 

One of the challenges we encountered was **developing the collision detection system**. We aimed for it to simulate reality, rather than merely having static towers firing projectiles in a predetermined direction. Our development team then were faced with the task of enabling towers to track the direction of germs, thereby adjusting the firing direction of the towers accordingly.
The solution we arrived at involved assigning each tower a specific range. Upon detecting nearby germs, the tower adjusts its firing direction to intersect with the approaching enemy, thus implementing collision detection effectively.

<p align="center">
  <img src="https://github.com/UoB-COMSM0110/2024-group-8/blob/main/images/projectiledirection.gif?raw=true" alt="Changing direction of projectile firing">
</p>

Moreover, **designing different types of enemies** was another challenging task to think about. We aimed to avoid repetitive enemy encounters throughout the game, as we believed it would lessen player engagement. We thought about a variety of enemy characters, each requiring distinct towers for defeat. In our design approach, we aimed to offer players a wide range of enemies throughout their gaming experience. This not only kept the gameplay fresh but also encouraged players to use their money wisely and strategize continuously so they could defeat the strongest enemies.

Another important aspect of our game was the **visual and auditory elements** around it. We recognized the critical role these elements play in immersing players in the gaming experience. With the goal of designing a visually aesthetic and captivating map, we spent considerable time designing organ maps and their corresponding paths for the germs, programming the placement parameters for towers (and making sure it was clear and easy to understand), and designing map-specific introduction and tutorial screens to guide players through the game mechanics. Furthermore, as the game progressed in development, we decided to add auditory elements to enrich the player’s experience. We strategically incorporated sound effects to evoke feelings of achievement, such as the sound of a germ being defeated or the satisfying ring when purchasing a tower. These auditory cues were instrumental in heightening player engagement and cultivating a sense of accomplishment throughout the game.


# Evaluation  

# Process  
(Process: Currently 654/750 words)

The process to develop the game was fairly intuitive. At the outset, all members of the group came together to brainstorm and think carefully about our ideas. We discussed a whole range of project ideas that the team welcomed and encouraged. Working with interested and passionate people was great - the project was propelled along as exciting ideas were discussed and then attempts were made to implement quickly after.   <br><br> 
Whilst roles were not initially formally assigned, they developed as we all followed a path-of-least-resistance. Kai Chun got the group up and running with an underlying structure for the base-code. Once this had been established, Arielle and Vincent joined him in developing the code structure and creating the start of a working prototype. Julia and Alex took on roles as researchers and in creating documentation. Julia added start pages and audio to the game, as well as editing and finalizing the tutorial page, Alex developed the video portion and both developed the overall report.<br><br>
As a structure, this worked well although the work-load was not always even distributed. It was found that once one person had started working on the code development, it was difficult to share this out without creating more complexities than were required. We found that these clearly delineated roles worked out best and allowed us each to take an element of the project as our own.<br><br>
If repeating this project with the knowledge that we now have, it might be wise to establish right from the beginning these roles - rather than from a few weeks in. Now that we have the understanding of each others’ talents and abilities, processes could be better run concurrently. 

<img src="https://github.com/UoB-COMSM0110/2024-group-8/blob/d762340a11e16ad27b0533fd30b93b436d8ccb9a/images/kanban_march.png" width="600" />

Figure X: Our KanBan board in March, during the development process.<br><br>
The kanban board (Figure X) was useful. It was great for establishing the initial ideas and concepts of the game. However, our development process meant that new ideas were often thought up and developed in a single motion - meaning that on occasion, a proposal was made and coded without being added to the board. If it wasn’t possible to develop into a neat solution, this addition was discarded. Additional items on the kanban board could have been useful here, but for our development process this wasn’t the case. If undertaken again, with better understanding of the Processing/Java development process, greater optimisation could be achieved using the board to its full potential. 

In our project development, we primarily utilized Processing as our coding platform, which provided robust tools for visual rendering and interaction design. However, we encountered challenges with Processing, particularly in the initial weeks of our project, as we familiarized ourselves with its syntax, libraries, and debugging processes. Nonetheless, as we gained proficiency, Processing became indispensable for implementing game mechanics and visual elements. For visual design, Adobe Photoshop served as our main tool, offering a versatile platform for creating characters, environments, and user interface elements with precision and detail. We sourced audio resources from royalty-free websites to enhance the immersive experience of the game, selecting sound effects.Through an iterative development process, we continuously refined and optimised our code, visual assets, and audio elements based on feedback and testing results. Detailed documentation of coding practices, visual design guidelines, and audio specifications ensured consistency and facilitated knowledge sharing among team members. 
Initially, we decided on meetings a couple of times a week during the early stages of our project. As our project progressed, we continued to meet regularly as a team, even further into the later stages of development. However, we also found that we maintained high levels of productivity when working independently at times. This approach allowed us to accommodate everyone's unique schedules and preferences while ensuring progress on the project. Our team's adeptness at balancing collaborative meetings with individual work sessions relied heavily on our exceptional communication skills.
Overall, our balanced blend of collaborative meetings and individual work sessions, supported by strong communication, contributed to the success and efficiency of our project development process.



<br><br><br><br><br><br><br><br><br><br><br><br><br><br>
*remainder of report to be finished*


# [Kanban Board](https://dramatic-clutch-d0e.notion.site/Group-8-Agile-Project-Management-bb06c2d090f543f9b2f2d0bc953f3d08) | [Photo Album](https://photos.app.goo.gl/bzxtsnzj8zHpwrJ6A)




 Human Body Tower Defence.
This game builds upon the widely popular Tower Defence style of game - where the aim is to protect a () from invaders. 
Using the human body as a thematic device, the game aims to provide some educational value in reinforcing the understanding of the body's mechanism to fight infection - whilst being fun and engaging for all ages. 

The novel aspects of this game are the ways in which interventions - either clinical or otherwise allow the user to influence in-game physics - from dieuretic tablets that increase the flow of invaders through the kidney, to smoke inhalation which weakens the health of enemies in the lungs.  


# Conclusion
In reflecting on the entirety of our project, "Immune System Defense," we definitely feel proud of achieving something that we initially thought would be unattainable. When we were first presented with the task of developing a game, we all thought we were going to really struggle not only in developing the coding mechanics of it, but also in coming up with an idea that even we would like to play in our free time.

Furthermore, delving into the theory behind agile project development enabled us to simulate a real-life scenario we may encounter in the near future: collaborative teamwork. This practical experience added depth to our learning journey and made us see first-hand how software developers work day to day.

We acknowledge that we were fortunate enough that our team got along well from the very beginning, and that gave us a big advantage. We were easygoing and open to knowing each other’s ideas and suggestions. A comfortable environment and workspace undoubtedly contributed to making the entire process more enjoyable and fulfilling.

As we progressed, we encountered adjustments in our game structure, as some initial ideas proved to be overly ambitious given our time constraints. This realization prompted us to adopt a more realistic approach to scheduling and game development, highlighting an area for improvement in future projects.

The challenges we were presented with - learning new software, the development process of our game - offered valuable insights into our growth and development as a team. If additional time and resources were available for further game development, we would like to implement a multiplayer mode. This would allow players to collaborate or compete with each other in defending the human body against invading germs. We would also be interested in developing a mobile version of the game, so that more people would be able to play where and when they wanted to.
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

