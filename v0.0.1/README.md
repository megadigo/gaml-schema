# GAML Schema v0.0.1

## Game AI Metadata Language (GAML) - JSON Schema Documentation

GAML is a structured format for defining complete game metadata specifications that can be used to generate playable games through AI assistance. This schema validates GAML files and ensures they contain all necessary information for game implementation.

---

## Table of Contents

- [Quick Start](#quick-start)
- [Schema Overview](#schema-overview)
- [Basic Example: Simple Shooter](#basic-example-simple-shooter)
- [Intermediate Example: Space Invaders](#intermediate-example-space-invaders)
- [Advanced Example: RPG Dungeon](#advanced-example-rpg-dungeon)
- [Creating Your Own GAML File](#creating-your-own-gaml-file)
- [Example: Dice Game Schema](#example-dice-game-schema)
- [Core Sections Reference](#core-sections-reference)
- [Validation](#validation)

---

## Quick Start

A minimal GAML file requires these core properties:

```yaml
---
file: my_game.gaml
version: "1.0"
description: "Brief description of the game"
schema: "https://github.com/megadigo/gaml-schema/blob/main/v0.0.1/gaml-schema.json"

game:
  name: "My Game"
  type: "Game Genre"
  description: "What the game is about"

project:
  name: "my_game"
  target: "web_browser"

window:
  width: 800
  height: 600
```

---

## Schema Overview

The GAML schema defines a complete game specification through these main sections:

- **Metadata**: File identification and version info
- **Game**: Core game information and credits
- **Project**: Build and deployment configuration
- **Window**: Display dimensions
- **Assets**: External resources (sprites, audio)
- **Entities**: Game objects (player, enemies, items)
- **Game World/Gameplayground**: Level generation and layout
- **Resources**: Initial state and input configuration
- **Game States**: Screen states (menu, playing, gameOver)
- **Gameplay Systems**: Movement, combat, AI, progression
- **Rendering**: Visual appearance configuration
- **Level Progression**: Advancement and difficulty scaling
- **Prompt Instructions**: AI implementation guidance

---

## Basic Example: Simple Shooter

Let's start with a simple Space Invaders-style game that demonstrates the core concepts:

### 1. File Header

```yaml
---
file: simple_shooter.gaml
version: "1.0"
description: |
  A basic shooter game where the player defends against falling enemies.
  Simple mechanics with score tracking and lives system.
schema: "https://github.com/megadigo/gaml-schema/blob/main/v0.0.1/gaml-schema.json"
```

### 2. Game Configuration

```yaml
game:
  name: "Simple Shooter"
  type: "2D Shooter"
  description: "Shoot enemies before they reach the bottom!"
  credits:
    developer: "Your Name"
    license: "MIT"
```

### 3. Project Setup

```yaml
project:
  name: "simple_shooter"
  target: "web_browser"
  page: "index.html"
  engine: "HTML5_Canvas"
  language: "Javascript"

implementation:
  approach: "single_file_html"
  dependencies: "none"
  canvas_id: "game-canvas"

window:
  width: 800
  height: 600
  title: "Simple Shooter"
```

### 4. Simple Entities

```yaml
entities:
  player:
    name: "Player Ship"
    sprite:
      color: "#00FF00"  # Green
      width: 40
      height: 40
    position:
      x: 400
      y: 550
    speed: 5
    bounds:
      min_x: 0
      max_x: 760
```

### 5. Game Resources

```yaml
resources:
  game_state:
    initial_lives: 3
    initial_score: 0
    initial_level: 1
  
  input_handling:
    keydown_events: true
    supported_keys: ["ArrowLeft", "ArrowRight", "Space"]
```

This simple example shows the minimum needed for a playable game!

---

## Intermediate Example: Space Invaders

The Space Invaders example (`space_invader_metadata.gaml`) demonstrates more complex features:

### Formation-based Enemies

```yaml
entities:
  invaders:
    name: "Invader Formation"
    type: "enemy_formation"
    sprite:
      color: "#FF0000"
      width: 40
      height: 40
    stats:
      count: 50          # Total enemies
      rows: 5
      columns: 10
      start_x: 150
      start_y: 100
      spacing_x: 80      # Horizontal spacing
      spacing_y: 60      # Vertical spacing
    movement:
      horizontal_speed: 15
      descent_amount: 20
      move_frequency: 40  # Frames between moves
    shooting:
      frequency: 30
      probability: 0.5
```

### Bullet System

```yaml
entities:
  bullets:
    player_bullet:
      size:
        width: 5
        height: 20
      color: "#00FF00"
      speed: 8
    enemy_bullet:
      size:
        width: 5
        height: 20
      color: "#FFFF00"
      speed: 3
```

### Multiple Game States

```yaml
game_states:
  menu:
    canvas_rendering:
      background: "#000000"
      ui_elements:
        - text: "SPACE INVADERS"
          font: "bold 72px Arial"
          color: "#FF8000"
          position:
            x: "center"
            y: 300
        - text: "Press SPACE to Start"
          font: "bold 40px Arial"
          color: "#00FF00"
          position:
            x: "center"
            y: 450
    input_transitions:
      space_key: "playing"
      h_key: "howToPlay"

  playing:
    canvas_rendering:
      background: "#000000"
      ui_elements:
        - text: "Lives: {lives}"
          font: "bold 50px Arial"
          color: "#FFFF00"
          position:
            x: 50
            y: 50
            align: "left"
    controls:
      movement: ["KeyA", "KeyD", "ArrowLeft", "ArrowRight"]
      shooting: ["Space"]
    collision_systems:
      - "player_bullets_vs_enemies"
      - "enemy_bullets_vs_player"
```

### Level Progression

```yaml
gameplay_conditions:
  level_progression:
    trigger: "all_enemies_destroyed"
    action: "increment_level_and_respawn_enemies"
    enemy_speed_increase: 15
    move_frequency_decrease: 5
    shoot_frequency_decrease: 5
    shoot_probability_increase: 0.05
  
  game_over_conditions:
    - "lives <= 0"
    - "enemies_reach_bottom"
```

---

## Advanced Example: RPG Dungeon

The RPG Dungeon example (`rpg_dungeon_metadata.gaml`) showcases the most complex features:

### Procedural Dungeon Generation

```yaml
game_world:
  dungeon:
    grid_size: 40
    rows: 15
    columns: 20
    offset_x: 20
    offset_y: 50
    generation_rules:
      algorithm: "Binary Space Partition"
      generation: "random_each_dungeon_level"
      rooms:
        room_count: 6
        room_min_size: 3
        room_max_size: 7
        corridor_width: 1
      floor_color: "#4A3728"
      walls:
        color: "#2C1810"
        render: "fillRect"
      exit_stairs:
        color: "#FFD700"
        spawn_rule: "farthest_room_from_player"
        requires: "all_enemies_defeated"
        detection_radius: 50
        interaction: "automatic_on_proximity"
```

### Sprite Sheet Integration

```yaml
assets:
  - type: "image"
    id: "sprite_sheet"
    path: "assets/tiny_dungeon_monsters.png"
    tile_size: 16
    grid_size: [16, 16]

entities:
  player:
    name: "Hero"
    sprite_sheet_spec:
      sprite_sheet: "sprite_sheet"
      sprite_positions:
        right: { row: 3, col: 8 }
        down: { row: 3, col: 9 }
        up: { row: 3, col: 10 }
        left: { row: 3, col: 11 }
      size: { width: 16, height: 16 }
      scale: 2
    spawn_position:
      rule: "first_room_center"
    stats:
      max_health: 100
      health: 100
      attack: 20
      defense: 5
      level: 1
      experience: 0
```

### Multiple Enemy Types

```yaml
entities:
  enemies:
    list:
      - name: "Acid Slime"
        type: "slimes"
        sprite_sheet: "sprite_sheet"
        sprite_sheet_spec:
          sprite_positions:
            right: { row: 16, col: 8 }
            down: { row: 16, col: 9 }
            up: { row: 16, col: 10 }
            left: { row: 16, col: 11 }
          size: { width: 16, height: 16 }
          scale: 2
        health: 30
        attack: 5
        defense: 2
        speed: 0.5
        experience_value: 20
        gold_drop: { min: 5, max: 15 }
        spawn_chance: 0.5
        ai_behavior:
          detection_range: 30
          chase_player: true
          attack_range: 15
          attack_cooldown: 60
      
      - name: "Deadly Skeleton"
        type: "skeletons"
        health: 50
        attack: 8
        defense: 4
        experience_value: 35
        gold_drop: { min: 10, max: 25 }
        spawn_chance: 0.3
    
    spawn_rules:
      enemies_per_room: { min: 1, max: 3 }
      scale_with_level: true
      exclude_player_room: true
      exclude_exit_room: true
```

### RPG Systems

```yaml
gameplay_systems:
  combat_system:
    player_attack:
      type: "ranged_projectile"
      trigger: "continuous_while_space_held"
      direction: "player_facing_direction"
      cooldown: 30
      damage_calculation: "base_attack * level_multiplier"
    damage_formula: "max(1, attacker.attack - defender.defense)"
  
  experience_system:
    level_up_formula: "100 * level"
    stat_gains_per_level:
      max_health: 10
      attack: 2
      defense: 1
    health_restore_on_level: "full"
  
  loot_system:
    gold_drops: true
    item_drops: true
    chest_contents: "random_gold_and_items"
  
  progression_system:
    floors: 10
    difficulty_scaling:
      enemy_health_multiplier: 1.2
      enemy_attack_multiplier: 1.15
      enemy_count_increase: 0.5
```

---

## Creating Your Own GAML File

### Step-by-Step Process

1. **Start with the basics** - file metadata, game info, window size
2. **Define your entities** - player, enemies, items
3. **Set up game states** - menu, playing, gameOver
4. **Add gameplay systems** - movement, collision, progression
5. **Configure rendering** - colors, shapes, sprites
6. **Write prompt instructions** - guide the AI implementation

### Best Practices

- Use clear, descriptive names for all entities and systems
- Provide hex color codes for all visual elements
- Define collision detection systems explicitly
- Include detailed descriptions in prompt_instruction
- Test with the validator before using

---

## Example: Dice Game Schema

Here's how you could structure a GAML file for a dice game:

### Basic Dice Game Structure

```yaml
---
file: dice_game.gaml
version: "1.0"
description: |
  A simple dice rolling game where players compete to reach a target score.
  Roll dice, make strategic choices, and race to victory!
schema: "https://github.com/megadigo/gaml-schema/blob/main/v0.0.1/gaml-schema.json"

game:
  name: "Dice Rush"
  type: "Dice Game"
  description: "Roll the dice and race to 100 points!"
  credits:
    developer: "Your Name"
    license: "MIT"

project:
  name: "dice_rush"
  target: "web_browser"
  page: "index.html"
  engine: "HTML5_Canvas"
  language: "Javascript"

window:
  width: 800
  height: 600
  title: "Dice Rush"
```

### Dice Game Assets

```yaml
assets:
  - type: "image"
    id: "dice_sprites"
    path: "assets/dice.png"
    tile_size: 64
    grid_size: [1, 6]  # 6 dice faces in a row
```

### Dice Entity Configuration

```yaml
entities:
  dice:
    name: "Game Dice"
    type: "interactive_object"
    count: 2  # Two dice
    sprite_sheet_spec:
      sprite_sheet: "dice_sprites"
      sprite_positions:
        face_1: { row: 0, col: 0 }
        face_2: { row: 0, col: 1 }
        face_3: { row: 0, col: 2 }
        face_4: { row: 0, col: 3 }
        face_5: { row: 0, col: 4 }
        face_6: { row: 0, col: 5 }
      size: { width: 64, height: 64 }
      scale: 1.5
    position:
      dice_1: { x: 250, y: 300 }
      dice_2: { x: 450, y: 300 }
    animation:
      roll_duration: 30  # frames
      bounce_effect: true
  
  players:
    list:
      - name: "Player 1"
        color: "#FF0000"
        initial_score: 0
        target_score: 100
      - name: "Player 2"
        color: "#0000FF"
        initial_score: 0
        target_score: 100
```

### Dice Game Resources

```yaml
resources:
  game_state:
    current_player: 1
    round_number: 1
    dice_values: [1, 1]
    turn_score: 0
    game_mode: "race_to_100"
  
  game_rules:
    rolling:
      max_rolls_per_turn: 3
      auto_end_on_doubles: false
    scoring:
      normal_sum: "sum_of_dice"
      doubles_multiplier: 2
      snake_eyes_penalty: -10  # Rolling two 1s
    turn_ending:
      player_choice: true  # Player can choose to end turn
      forced_end: "after_3_rolls"
  
  input_handling:
    keydown_events: true
    supported_keys: ["Space", "KeyR", "KeyH", "Enter"]
```

### Dice Game States

```yaml
game_states:
  menu:
    canvas_rendering:
      background: "#1a4d1a"
      ui_elements:
        - text: "DICE RUSH"
          font: "bold 72px Arial"
          color: "#FFD700"
          position: { x: "center", y: 150 }
        - text: "First to 100 Points Wins!"
          font: "30px Arial"
          color: "#FFFFFF"
          position: { x: "center", y: 250 }
        - text: "Press SPACE to Start"
          font: "bold 36px Arial"
          color: "#00FF00"
          position: { x: "center", y: 400 }
    input_transitions:
      space_key: "playing"
      h_key: "howToPlay"
  
  playing:
    canvas_rendering:
      background: "#1a4d1a"
      ui_elements:
        - text: "Player 1: {player1_score}"
          font: "bold 32px Arial"
          color: "#FF0000"
          position: { x: 50, y: 50, align: "left" }
        - text: "Player 2: {player2_score}"
          font: "bold 32px Arial"
          color: "#0000FF"
          position: { x: 750, y: 50, align: "right" }
        - text: "Current Player: {current_player}"
          font: "28px Arial"
          color: "#FFFF00"
          position: { x: "center", y: 100 }
        - text: "Turn Score: {turn_score}"
          font: "24px Arial"
          color: "#FFFFFF"
          position: { x: "center", y: 500 }
        - text: "Rolls Left: {rolls_remaining}"
          font: "20px Arial"
          color: "#CCCCCC"
          position: { x: "center", y: 530 }
        - text: "Press SPACE to Roll | ENTER to End Turn"
          font: "18px Arial"
          color: "#AAAAAA"
          position: { x: "center", y: 570 }
    controls:
      roll_dice: ["Space"]
      end_turn: ["Enter"]
      bank_score: ["KeyB"]
  
  victory:
    canvas_rendering:
      background: "#1a4d1a"
      ui_elements:
        - text: "WINNER!"
          font: "bold 80px Arial"
          color: "#FFD700"
          position: { x: "center", y: 200 }
        - text: "{winner_name} Wins!"
          font: "48px Arial"
          color: "{winner_color}"
          position: { x: "center", y: 300 }
        - text: "Final Score: {final_score}"
          font: "36px Arial"
          color: "#FFFFFF"
          position: { x: "center", y: 380 }
        - text: "Press R to Play Again"
          font: "28px Arial"
          color: "#00FF00"
          position: { x: "center", y: 500 }
    input_transitions:
      r_key: "playing"
```

### Dice Gameplay Systems

```yaml
gameplay_systems:
  dice_rolling:
    animation:
      enabled: true
      duration: 30  # frames
      rotation_speed: 15  # degrees per frame
      bounce_height: 20  # pixels
    randomization:
      method: "crypto_random"  # Use secure random for fairness
      range: [1, 6]
  
  turn_management:
    turn_phases:
      - "roll_dice"
      - "display_result"
      - "calculate_score"
      - "player_decision"
      - "end_turn"
    automatic_progression: false
    player_controls_turn: true
  
  scoring_system:
    calculation_rules:
      normal_roll: "dice1 + dice2"
      doubles: "(dice1 + dice2) * 2"
      snake_eyes: "-10"  # Two 1s
      triple_sixes: "instant_win"  # Special rule
    accumulation:
      turn_score_temporary: true
      bank_on_end_turn: true
      lose_on_snake_eyes: true
  
  win_conditions:
    primary: "score >= 100"
    alternative: "triple_sixes_rolled"
    
rendering:
  method: "canvas_2d"
  shapes:
    dice:
      type: "sprite"
      animation: "rotation_and_bounce"
    score_display:
      type: "text"
      background: "rounded_rectangle"
      border: "2px solid"
  effects:
    dice_roll:
      - "rotation_animation"
      - "bounce_effect"
      - "shadow"
    score_change:
      - "number_count_up"
      - "color_flash"
```

### Dice Game Prompt Instructions

```yaml
prompt_instruction:
  GAME_MECHANICS:
    - Implement a turn-based dice game for 2 players
    - Each turn, player can roll dice up to 3 times
    - Player can choose to bank their score and end turn anytime
    - Rolling snake eyes (two 1s) loses all points for that turn
    - Rolling doubles multiplies the turn score by 2
    - First player to reach 100 points wins
  
  DICE_ANIMATION:
    - Animate dice rolling with rotation and bounce effect
    - Show dice values clearly after animation completes
    - Duration should be 0.5 seconds (30 frames at 60fps)
    - Add sound effect for dice rolling (optional)
  
  UI_REQUIREMENTS:
    - Display both players' scores prominently
    - Show current player's turn clearly
    - Display turn score separately from total score
    - Show rolls remaining in current turn
    - Provide clear button prompts for actions
  
  IMPLEMENTATION:
    - Use HTML5 Canvas for rendering
    - Single file implementation (HTML + CSS + JS)
    - No external dependencies
    - Responsive to keyboard input (Space to roll, Enter to end turn)
    - Use requestAnimationFrame for smooth animations
```

---

## Core Sections Reference

### Required Properties

Every GAML file must include:

- `file` - The filename
- `version` - GAML file version
- `description` - What this file defines
- `schema` - URL to this schema
- `game.name` - Game title
- `game.type` - Game genre
- `game.description` - Game overview
- `project.name` - Project folder name
- `project.target` - Target platform
- `window.width` - Canvas width
- `window.height` - Canvas height

### Optional but Recommended

- `game.credits` - Attribution
- `assets` - Sprite sheets, audio files
- `game_states` - Menu, playing, gameOver screens
- `gameplay_systems` - Movement, combat, progression
- `prompt_instruction` - AI implementation guidance

### Data Type Reference

| Type | Example | Description |
|------|---------|-------------|
| String | `"my_value"` | Text values |
| Number | `42` | Integers or decimals |
| Boolean | `true` | true or false |
| Color | `"#FF0000"` | Hex color code |
| Array | `[1, 2, 3]` | List of values |
| Object | `{x: 10, y: 20}` | Nested properties |
| Null | `null` | Empty value |

---

## Validation

### Using the Validator

```bash
cd validator
npm install
node validate-gaml.js
```

### Common Validation Errors

**Missing required property:**
```
Error: must have required property 'name'
Path: /game
```
Solution: Add the missing property to the specified path.

**Invalid type:**
```
Error: must be number
Path: /window/width
```
Solution: Ensure the value is the correct type (remove quotes for numbers).

**Invalid enum value:**
```
Error: must be equal to one of the allowed values
```
Solution: Check the schema for valid options.

### Validation Tips

1. Start with a minimal valid file
2. Add sections incrementally
3. Validate after each major change
4. Check the examples for reference
5. Use proper YAML syntax (indentation matters!)

---

## Additional Resources

- **Examples Directory**: `v0.0.1/examples/` contains three complete game specifications
- **Schema File**: `v0.0.1/gaml-schema.json` - Full JSON schema definition
- **Validator**: `validator/` - Validation tool and results

---

## Tips for Complex Games

### Dice Game Advanced Features

For a more complex dice game, consider adding:

1. **Multiple Game Modes**
   - Race to score
   - Highest score in N rounds
   - Elimination mode

2. **Power-ups and Special Dice**
   - Lucky dice (re-roll once)
   - Weighted dice (better odds)
   - Cursed dice (risk/reward)

3. **AI Opponents**
   - Strategy levels (conservative, aggressive, balanced)
   - Difficulty scaling
   - Decision-making AI

4. **Statistics and Achievements**
   - Track rolls, wins, streaks
   - Unlock achievements
   - Leaderboard system

5. **Visual Effects**
   - Particle effects on special rolls
   - Screen shake on doubles
   - Victory animations

### General Advanced Tips

- **Modular Design**: Break complex systems into smaller, testable parts
- **Data-Driven**: Use configuration objects for easy tweaking
- **Progressive Enhancement**: Start simple, add features incrementally
- **Clear Documentation**: Detailed prompt_instruction helps AI understand intent
- **Test Thoroughly**: Validate edge cases and win/loss conditions

---

## License

This schema and documentation are part of the GAML project. See individual game examples for their respective licenses.

---

## Version History

- **v0.0.1** (2025-10-24) - Initial release
  - Core schema structure
  - Support for 2D games (shooters, RPGs, maze games)
  - Validation tools
  - Comprehensive documentation

---

**Questions or Issues?** Check the examples in `v0.0.1/examples/` or consult the schema file directly.
