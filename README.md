# Game AI Markup Language (GAML) Schema

## Overview

**GAML** (Game AI Markup Language) is a universal schema designed for defining game specifications in a structured JSON format. It enables AI-driven, single-prompt game generation by providing a comprehensive framework that supports any game genre.

- **Current Version**: 0.0.1
- **Schema Version**: Follows semantic versioning (e.g., `0.0.1`, `0.1.0`, `1.0.0`)
- **Format**: JSON Schema (Draft-07)
- **Repository**: https://github.com/megadigo/gaml-schema
- **Schema Location**: `v0.0.1/gaml-schema.json`

## Purpose

GAML provides a standardized way to describe complete game specifications including:
- Game metadata and project configuration
- Entity definitions (players, enemies, NPCs, items)
- Gameplay mechanics and systems
- Level generation and progression
- Audio and visual assets
- Input handling and game states
- Win/lose conditions

## Core Structure

A GAML file consists of the following main sections:

### 1. **Metadata**
```json
{
  "file": "game_name.gaml",
  "version": "0.1",
  "description": "Game description",
  "schema": "https://github.com/megadigo/gaml-schema/v0.0.1"
}
```
Required fields: `file`, `version`, `description`, `schema`, `game`, `project`, `window`

### 2. **Game Definition**
- **name**: Display name of the game
- **type**: Genre (Action RPG, Maze Chase, 2D Shooter, Platformer, Puzzle, Strategy, etc.)
- **extend**: Optional base template to extend from
- **version**: Game version number
- **description**: Detailed game mechanics

### 3. **Project Configuration**
- **name**: Project directory name
- **target**: Deployment platform (web_browser, desktop, mobile, console)
- **page**: Main HTML file (for web games)
- **engine**: Rendering engine (HTML5_Canvas, WebGL, SVG, DOM, Three.js, Phaser)
- **language**: Programming language (Javascript, TypeScript, Python, Java, C#, C++)
- **structure**: Expected file structure

### 4. **Implementation Settings**
- **approach**: Development approach (single_file_html, multi_file, module_based, webpack_bundled)
- **dependencies**: Dependency level (none, minimal, standard, full)
- **canvas_id**: HTML canvas element identifier

### 5. **Assets**
Define game resources:
- Images
- Audio files
- Fonts
- Sprite sheets (with tile size and grid configuration)
- Tilemaps
- Videos
- Data files

### 6. **Window Configuration**
- Dimensions (width, height)
- Title
- Resizable/fullscreen support

### 7. **Game World / Playground**
Configure gameplay areas with:
- Grid-based layouts (rows, columns, grid size)
- Rendering offsets
- **Generation rules**:
  - Algorithms (Binary Space Partition, Cellular Automata, Depth-First Search, Perlin Noise, Random Walk)
  - Room parameters (count, min/max size)
  - Corridor width
  - Colors (walls, floors, paths, doors)
  - Rendering methods

### 8. **Entities**

#### Player
- Shape (circle, rectangle, triangle, sprite, polygon)
- Sprite sheet specifications
- Size and color
- **Spawn position**: Supports multiple formats:
  - Direct coordinates: `{x: 600, y: 750}` or `{grid_x: 5, grid_y: 10}`
  - Rule-based: `{rule: "first_room_center"}` (e.g., "first_room_center", "last_room_center", "random_room", "center", "random")
- Speed and movement
- Stats (health, attack, defense, level, experience)
- Combat configuration
- Inventory
- Animation properties
- Movement bounds

#### Enemies
Two configuration modes:

**1. List-based** (for RPGs, roguelikes, etc.):
```json
{
  "list": [
    {
      "name": "Acid Slime",
      "type": "slimes",
      "sprite_sheet_spec": {...},
      "health": 30,
      "attack": 5,
      "defense": 2,
      "speed": 1,
      "experience_value": 20,
      "gold_drop": {"min": 5, "max": 15},
      "spawn_chance": 0.5,
      "ai_behavior": {
        "detection_range": 50,
        "chase_player": false,
        "attack_range": 30,
        "attack_cooldown": 60
      }
    }
  ],
  "spawn_rules": {
    "enemies_per_room": {"min": 1, "max": 3},
    "scale_with_level": true,
    "exclude_player_room": true,
    "exclude_exit_room": true
  }
}
```

**2. Formation-based** (for Space Invaders-style games):
```json
{
  "count": 50,
  "formation": {
    "rows": 5,
    "columns": 10,
    "start_x": 150,
    "start_y": 100,
    "spacing_x": 80,
    "spacing_y": 60
  },
  "size": {"width": 40, "height": 40},
  "color": "#FF0000",
  "movement": {
    "horizontal_speed": 15,
    "descent_amount": 20,
    "move_frequency": 40
  },
  "shooting": {
    "frequency": 30,
    "probability": 0.5
  }
}
```

Enemy properties (list-based):
- Name and type
- Visual appearance (sprite, size, color, scale)
- Stats (health, attack, defense, speed)
- Experience value and gold drops
- Spawn chance and spawn rules
- AI behavior (detection range, chase_player, attack_range, attack_cooldown, patrol, flee_on_low_health)

#### Items
- Name and type
- Visual properties
- Effects
- Spawn rules
- Container contents (for chests, etc.)

#### Projectiles
- Shape (circle, rectangle, sprite)
- Size, color, speed
- Lifetime (in frames)
- Damage calculation

#### NPCs
- Name and type
- Position
- Dialogue trees

#### Obstacles
- Type and position
- Size
- Destructible flag

### 9. **Resources**

#### Game State
- Initial values (lives, level, score, floor, gold, potions)
- Points per enemy
- Max floor/level

#### Available Game States
- Menu
- Playing
- Paused
- Game Over
- Victory
- Level Up
- Loading

#### Input Handling
- Keyboard events (keydown, keyup)
- Supported keys (Arrow keys, WASD, Space, Enter, Escape, etc.)
- Mouse events (click, mousemove, mousedown, mouseup, wheel)
- Touch events
- Gamepad support

#### Audio Configuration
- Music tracks (with loop settings)
- Sound effects
- Enable/disable flag

### 10. **Gameplay Systems**

#### Player Movement
- Control keys mapping
- Movement type (continuous, grid_based, physics, tile_based)
- Speed and acceleration
- Diagonal movement support
- Collision handling
- Friction

#### Combat System
- Player attack (ranged_projectile, melee, area_of_effect, hitscan)
- Enemy attack patterns
- Damage formulas
- Critical hits (chance and multiplier)
- Knockback
- Attack cooldowns

#### Experience System
- Level-up formula
- Stat gains per level
- Health restoration on level-up

#### Loot System
- Gold drops
- Item drops
- Chest contents
- Drop rates

#### Progression System
- Floors/levels/waves
- Difficulty scaling:
  - Enemy health multiplier
  - Enemy attack multiplier
  - Enemy count increase
  - Enemy speed multiplier

#### Physics System
- Gravity
- Friction
- Bounce
- Collision detection (AABB, circle, polygon, pixel_perfect)

#### Scoring System
- Points per enemy/level
- Combo multipliers
- High score tracking

### 11. **Game States Configuration**
Detailed settings for each state:
- Duration (for temporary states)
- Canvas rendering (background, UI elements)
- Input transitions (key-to-state mappings)
- Auto transitions with delays
- Control mappings
- Active collision systems

### 12. **Level Progression**
- Trigger conditions
- Requirements
- Actions
- Difficulty increase rules

### 13. **Win/Lose Conditions**
Arrays of conditions that determine:
- Game over scenarios
- Victory requirements

### 14. **AI Prompt Instructions**
Detailed instructions for AI-driven game implementation, guiding the generation process.

## Key Features

### Flexible Entity System
GAML supports diverse entity types with customizable properties, from simple shapes to complex sprite-based characters.

### Procedural Generation
Built-in support for multiple generation algorithms to create dynamic game worlds.

### Multi-Genre Support
The schema accommodates various game genres:
- RPGs and Roguelikes
- Maze/Chase games (Pac-Man style)
- Shooters (Space Invaders, bullet hell)
- Platformers
- Puzzle games
- Strategy games
- Racing games
- Fighting games
- Card games
- Tower Defense

### Extensibility
Use the `extend` property to build upon existing game templates, promoting code reuse.

### Cross-Platform
Target multiple platforms (web, desktop, mobile, console) with appropriate engine and language selections.

## Data Types and Definitions

### Position Configuration
Supports multiple formats for positioning entities:
- **Pixel coordinates**: `{"x": 600, "y": 750}`
- **Grid coordinates**: `{"grid_x": 5, "grid_y": 10}`

### Spawn Position Configuration
Extends position configuration with rule-based options:
- **Direct coordinates**: Same as position configuration
- **Rule-based positioning**: `{"rule": "first_room_center"}`
  - Available rules: `"first_room_center"`, `"last_room_center"`, `"random_room"`, `"center"`, `"random"`

### Size Configuration
- Circular: `{radius}`
- Rectangular: `{width, height}`

### Range Configuration
```json
{
  "min": number,
  "max": number
}
```

### Sprite Sheet Specification
- Asset reference
- Sprite positions for different states/directions
- Size and scale

### Color Format
Hex color codes: `#RRGGBB` (e.g., `#FF0000` for red)

## Example Use Cases

1. **Roguelike RPG**: Define dungeon generation, character stats, combat mechanics, and loot system
2. **Maze Chase Game**: Configure maze layout, ghost AI behaviors, pellet collection, and power-ups
3. **Space Shooter**: Set up enemy formations, projectile systems, wave progression, and scoring
4. **Platformer**: Design level layouts, physics parameters, enemy patterns, and collectibles

## Validation

The schema uses JSON Schema Draft-07 for validation, ensuring:
- Required properties are present
- Data types are correct
- Values fall within specified ranges
- Enums contain only allowed values
- Patterns match (e.g., hex colors, file extensions)

## File Extension

GAML files use the `.gaml` extension and must reference this schema for validation.

## Versioning

The schema follows semantic versioning:
- **Major** (x.0.0): Breaking changes that are not backward compatible
- **Minor** (0.x.0): New features that are backward compatible
- **Patch** (0.0.x): Bug fixes and minor improvements

Each version is stored in its own directory (e.g., `v0.0.1/`, `v0.1.0/`) to maintain version history and allow projects to reference specific schema versions.

To reference a specific schema version in your GAML file:
```json
{
  "schema": "https://github.com/megadigo/gaml-schema/v0.0.1"
}
```

## Contributing

This schema is designed to be comprehensive yet extensible. Additional properties are allowed in many sections to accommodate novel game mechanics not explicitly defined in the base schema.

---

**Schema Version**: 0.0.1  
**Last Updated**: October 23, 2025  
**Maintainer**: megadigo

## Version History

### v0.0.1 (October 23, 2025)
- Initial release of GAML schema
- Complete support for multiple game genres
- Comprehensive entity system (player, enemies, NPCs, items, projectiles, obstacles)
- Gameplay systems (movement, combat, experience, loot, progression, physics, scoring)
- Procedural generation support with multiple algorithms
- Game state management and input handling
- Asset and audio configuration
- Cross-platform project configuration
