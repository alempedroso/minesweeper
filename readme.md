## MINESWEEPER

It's a simple engine to play the minesweeper game.
Instructions are given during the gameplay.

## Docker

### Building the project

```bash
docker-compose build
```

### Running app

```bash
docker-compose run app sh -c "ruby /myapp/start_game.rb"
```

### Running tests

```bash
docker-compose run app sh -c "ruby /myapp/tests.rb"
```
