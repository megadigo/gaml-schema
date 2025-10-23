# GAML Schema Documentation

## Game AI Markup Language (GAML) v0.0.1

GAML (Game AI Markup Language) is a universal schema for defining complete game specifications that can be used for single-prompt game generation. It provides a structured, comprehensive way to describe any game genre, from classic arcade games to complex RPGs, enabling AI systems to generate fully functional games from a single specification file.

## Table of Contents

1. [Overview](#overview)
2. [Schema Structure](#schema-structure)
3. [Core Components](#core-components)
4. [Game Genre Support](#game-genre-support)
5. [Examples](#examples)
6. [Implementation Guide](#implementation-guide)
7. [Best Practices](#best-practices)

## Overview

GAML is designed to capture every aspect of a game's design and implementation requirements in a single, structured format. The schema supports:

- **Universal Game Genre Support**: Action RPGs, Maze Games, 2D Shooters, Platformers, Puzzle Games, Strategy Games, and more
- **Single-Prompt Generation**: Complete specifications that enable AI to generate fully functional games
- **Multiple Target Platforms**: Web browsers, desktop applications, mobile devices, and consoles
- **Flexible Implementation**: Support for various engines (HTML5 Canvas, WebGL, Phaser, Three.js) and languages
- **Comprehensive Asset Management**: Images, audio, fonts, data files, and sprite sheets
- **Advanced Game Systems**: Physics, combat, progression, AI behavior, and procedural generation

## Schema Structure

The GAML schema is organized into several main sections:

### Required Root Properties

```yaml
file: "game_metadata.gaml"              # GAML filename
version: "2.0"                          # GAML specification version  
description: "Game description..."       # Multi-line game description
schema: "https://github.com/..."        # Schema validation URI
game: { ... }                           # Game metadata
project: { ... }                        # Project configuration
window: { ... }                         # Display/window settings
```

## Core Components

### 1. Game Metadata (`game`)

Defines the basic game information and categorization:

```yaml
game:
  name: "Space Invaders"
  type: "2D Shooter"                    # Genre classification
  extend: "classic_shooter"             # Optional base template
  version: "1.0"
  description: "Classic space shooter with formation enemies"
```

**Supported Game Types:**
- `Action RPG`, `Maze Chase`, `2D Shooter`, `Platformer`
- `Puzzle`, `Strategy`, `Racing`, `Fighting`  
- `Card Game`, `Tower Defense`

### 2. Project Configuration (`project`)

Specifies technical implementation details:

```yaml
project:
  name: "space_invaders"
  target: "web_browser"                 # web_browser, desktop, mobile, console
  page: "index.html"                    # Main HTML file
  engine: "HTML5_Canvas"                # Rendering engine
  language: "Javascript"               # Programming language
  structure:                            # Expected file structure
    - "index.html"
    - "assets/"
```

### 3. Implementation Details (`implementation`)

Technical approach and dependencies:

```yaml
implementation:
  approach: "single_file_html"          # single_file_html, multi_file, module_based
  dependencies: "none"                  # External libraries (or "none")
  canvas_id: "game-canvas"              # HTML canvas element ID
```

### 4. Assets Management (`assets`)

Comprehensive asset specification:

```yaml
assets:
  - type: "image"
    id: "player_sprite"
    path: "assets/player.png"
    format: "png"
  - type: "sprite_sheet"
    id: "enemies"
    path: "assets/enemies.png"
    tile_size: 32
    grid_size: [8, 4]                   # columns, rows
  - type: "audio"
    id: "shoot_sound"
    path: "assets/shoot.wav"
    format: "wav"
```

### 5. Window Configuration (`window`)

Display and viewport settings:

```yaml
window:
  width: 1200                           # Canvas width in pixels
  height: 800                           # Canvas height in pixels
  title: "Game Title"                   # Window/page title
  resizable: false                      # Resize capability
  fullscreen: true                      # Fullscreen support
```

### 6. Game World Definition

For RPGs and exploration games:

```yaml
game_world:
  dungeon:
    grid_size: 40                       # Cell size in pixels
    rows: 15
    columns: 20
    offset_x: 20                        # Rendering offset
    offset_y: 50
    generation_rules:
      algorithm: "Binary Space Partition"
      generation: "random"              # random, seeded, predefined
      room_count: 6
      wall_color: "#2C1810"
      floor_color: "#4A3728"
```

### 7. Gameplay Areas

For maze games and structured playgrounds:

```yaml
gameplayground:
  maze:
    grid_size: 20                       # Cell size in pixels  
    rows: 29
    columns: 29
    generation_rules:
      algorithm: "Depth-First Search"
      path_color: "#000000"
      wall_color: "#0000FF"
      pellet_placement: "every_path_cell"
```

### 8. Entity System (`entities`)

Comprehensive entity definitions:

```yaml
entities:
  player:
    name: "Player Ship"
    shape: "triangle"                   # circle, rectangle, triangle, sprite
    size: { width: 50, height: 50 }
    color: "#0080FF"
    spawn_position: { x: 600, y: 750 }
    speed: 5                            # pixels per frame
    stats:
      health: 100
      attack: 10
      level: 1
    
  enemies:
    name: "Invader Formation"
    type: "enemy_formation"             # enemy_formation or enemy_list
    sprite: { color: "#FF0000", width: 40, height: 40 }
    stats:
      count: 50
      rows: 5
      columns: 10
      spacing_x: 80
      spacing_y: 60
```

### 9. Game States Management

Complete state system with UI and transitions:

```yaml
game_states:
  menu:
    canvas_rendering:
      background: "#000000"
      ui_elements:
        - text: "GAME TITLE"
          font: "bold 72px Arial"
          color: "#FF8000"
          position: { x: "center", y: 300 }
    input_transitions:
      space_key: "playing"
      
  playing:
    controls:
      movement: ["KeyA", "KeyD", "ArrowLeft", "ArrowRight"]
      shooting: ["Space"]
    collision_systems:
      - "player_bullets_vs_enemies"
      - "enemy_bullets_vs_player"
```

### 10. Gameplay Systems

Advanced game mechanics:

```yaml
gameplay_systems:
  player_movement:
    keys: 
      left: ["KeyA", "ArrowLeft"]
      right: ["KeyD", "ArrowRight"]
    speed: 5
    boundaries: { left: 0, right: "canvas.width - player.width" }
    
  combat_system:
    player_attack_range: 50
    damage_calculation: "attack - defense"
    critical_hit_chance: 0.1
    
  physics_system:
    gravity: 0.5
    friction: 0.8
    collision_detection: "AABB"         # AABB, circle, polygon
```

### 11. Level Progression

Dynamic difficulty and progression:

```yaml
level_progression:
  trigger: "all_enemies_destroyed"
  action: "increment_level_and_respawn_enemies"
  enemy_speed_increase: 15              # Speed increment per level
  shoot_frequency_decrease: 5           # Faster shooting each level
```

## Game Genre Support

### 2D Shooters (Space Invaders Style)
- Formation-based enemy movement
- Bullet collision systems
- Lives and scoring
- Progressive difficulty

### Maze Games (Pac-Man Style)  
- Procedural maze generation
- Pellet collection mechanics
- Ghost AI with multiple behaviors
- Power-up systems

### Action RPGs (Dungeon Crawlers)
- Procedural dungeon generation
- Character stats and progression
- Inventory and loot systems
- Combat mechanics

### Platformers
- Physics-based movement
- Level design tools
- Collision detection
- Power-ups and collectibles

## Examples

The schema includes three comprehensive examples:

### 1. Space Invaders (`space_invader_metadata.gaml`)
A complete 2D shooter specification featuring:
- Formation enemy movement with descent behavior
- Player ship with triangle rendering
- Bullet collision systems
- Lives, scoring, and level progression
- Menu, playing, and game over states

### 2. Pac-Man (`pacman_metadata.gaml`)
A maze-based chase game specification featuring:
- Procedural maze generation using Depth-First Search
- Ghost AI with different behaviors
- Pellet and power pellet mechanics
- Ghost house spawn area
- Frightened ghost mechanics

### 3. RPG Dungeon (`rpg_dungeon_metadata.gaml`)
An action RPG specification featuring:
- Binary Space Partition dungeon generation
- Character stats and progression system
- Combat mechanics with attack/defense
- Inventory and loot systems
- Multiple enemy types with AI behaviors

## Implementation Guide

### Using GAML Files

1. **Create a .gaml file** following the schema structure
2. **Validate against the JSON schema** at the specified URI
3. **Generate the game** using an AI system or custom parser
4. **Deploy** according to the project configuration

### Single-Prompt Generation

GAML files are designed for single-prompt AI generation. The `prompt_instruction` field provides specific implementation guidance:

```yaml
prompt_instruction: |
  Create a complete 2D Space Invaders game using this GAML specification.
  
  CRITICAL REQUIREMENTS:
  1. Use HTML5 Canvas with vanilla JavaScript - NO external libraries
  2. Create a single index.html file with embedded CSS and JavaScript
  3. Canvas dimensions: 1200x800 pixels
  4. Game loop using requestAnimationFrame()
  
  ENTITIES AND BEHAVIOR:
  - Player: Blue triangle, moves with A/D or arrows, shoots with space
  - Enemies: Red rectangles in 5x10 formation, move as swarm
  - Collision detection using rectangular overlap
```

### Validation

Validate your GAML files against the JSON schema:

```javascript
const schema = await fetch('https://github.com/megadigo/gaml-schema/v0.0.1/gaml-schema.json');
const validator = new JSONSchemaValidator(schema);
const isValid = validator.validate(gamlData);
```

## Best Practices

### 1. Complete Specifications
- Include all required fields for your game genre
- Provide detailed entity configurations
- Specify exact colors, sizes, and positions
- Include comprehensive game state definitions

### 2. Clear Implementation Instructions
- Use the `prompt_instruction` field for specific requirements
- Specify exact technical constraints
- Include deployment and setup requirements
- Provide validation criteria

### 3. Consistent Naming
- Use descriptive entity names
- Follow consistent color schemes
- Use standard key bindings
- Maintain consistent coordinate systems

### 4. Flexible Design
- Support multiple input methods
- Include optional audio assets
- Provide fallback behaviors
- Consider different screen sizes

### 5. Comprehensive Testing
- Include win/lose conditions
- Specify collision detection methods
- Test all game state transitions
- Validate all entity interactions

## Schema Validation

The GAML schema is a JSON Schema Draft-07 specification. It includes:

- **Type validation** for all properties
- **Required field enforcement** 
- **Pattern validation** for strings (colors, versions, filenames)
- **Enum constraints** for categorical values
- **Nested object validation** using `$ref` definitions
- **Array validation** with item constraints

## Version History

- **v0.0.1**: Initial GAML specification
  - Core game metadata structure
  - Entity system with player, enemies, projectiles
  - Game state management
  - Asset management system
  - Gameplay systems framework
  - Level progression mechanics

## Contributing

The GAML schema is designed to be extensible. To contribute:

1. Review existing game genre implementations
2. Propose new game type support
3. Extend entity system capabilities  
4. Add new gameplay system definitions
5. Improve validation constraints

---

*GAML enables single-prompt generation of complete, functional games across any genre. The schema provides the structure, examples provide the patterns, and AI provides the implementation.*