file: masterdataschema.gaml
version: 1.0
description: |
  Metadata specification for the Space-Invaders game project.
  This file outlines the game's structure, entities, resources, states, and gameplay systems.
schema: game-schema.json
sections:
  - name: "GameMetadata"
    description: "Contains metadata about the game, including its name, type, and description."
  - name: "ProjectStructure"
    description: "Describes the folder structure and organization of the project files."
  - name: "GameplaySystems"
    description: "Details the various gameplay systems and mechanics implemented in the game."

steps:
  - step: "Set up the project structure as per the ProjectStructure section."
  - step: "Implement the game entities and their properties as defined in the GameMetadata section."
  - step: "Develop the gameplay systems outlined in the GameplaySystems section."
  - step: "Integrate audio and visual assets into the game."
  - step: "Test the game thoroughly to ensure all features work as intended."
  - step: "Optimize performance and fix any bugs found during testing."
  - step: "Package the game for deployment on itch.io as a web application."
  
instructions: |
  The file masterdata.gaml will give the structure of file
  Ensure adherence to the metadata.gaml and the game_metadata.gaml for a faithful recreation of the game.
  Implement all game systems, components, and features as specified in the metadata.
  Use engine best practices for game architecture and organization.
  Follow a modular approach, separating concerns into different components and systems.
  Comment the code thoroughly to explain the purpose of each section and function.
  Test the game thoroughly to ensure all features work as intended and there are no bugs.
  Optimize performance by profiling and addressing any bottlenecks.
  Package the final game for deployment on itch.io as a web application.
  Create a README file with instructions for playing the game and any other relevant information.