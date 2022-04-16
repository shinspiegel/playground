using Godot;
using System;

public class Main : Node2D
{
  [Signal] public delegate void DifficultyChanged(int difficulty);
  [Signal] public delegate void ScoreChange(int score);

  [Export] public int difficulty = 0;
  [Export] public int score = 0;

  public Spawner spawner;
  public Position2D playerStartPos;
  public Player player;
  public UI ui;

  public override void _Ready()
  {
    PersistentGameData.SaveScore(0);

    playerStartPos = GetNode<Position2D>("StartPlayer");
    player = GetNode<Player>("Player");
    spawner = GetNode<Spawner>("Spawner");
    spawner.main = this;
    ui = GetNode<UI>("UI");

    spawner.Connect(nameof(Spawner.SpawnTimeout), this, nameof(Main.OnTimerOut));
    player.Connect(nameof(Player.UpdatedAmmo), ui, nameof(UI.OnChargeChange));
    Connect(nameof(Main.DifficultyChanged), ui, nameof(UI.OnDifficultyChange));
    Connect(nameof(Main.ScoreChange), ui, nameof(UI.OnScoreChange));

    StartGame();
  }

  public void StartGame()
  {
    player.GlobalPosition = playerStartPos.GlobalPosition;
  }

  public void OnPlayerDied()
  {
    PersistentGameData.SaveScore(score);
    GetTree().ChangeSceneTo(ResourceLoader.Load<PackedScene>("res://Scenes/GameOver.tscn"));
  }

  public void OnTimerOut()
  {
    SpawnWave();
    difficulty += 1;
    EmitSignal(nameof(Main.DifficultyChanged), difficulty);
  }

  public void SpawnWave()
  {
    if (difficulty == 0)
    {
      spawner.SpawnOneEnemy(
        enemyScene: spawner.downWaitEnemyScene,
        scoreValue: 1
      );
      spawner.TimeForNextWave(5);
      return;
    }

    if (difficulty == 1)
    {
      spawner.SpawnOneEnemy(
        enemyScene: spawner.downWaitEnemyScene,
        scoreValue: 1
      );
      spawner.TimeForNextWave(5);
      return;
    }

    if (difficulty == 2)
    {
      spawner.SpawnTwoEnemies(
        enemyScene: spawner.downWaitEnemyScene,
        scoreValue: 1,
        option: 0
      );
      spawner.TimeForNextWave(4);
      return;
    }

    if (difficulty == 3)
    {
      spawner.SpawnOneEnemy(
        enemyScene: spawner.downEnemyScene,
        scoreValue: 2
      );
      spawner.TimeForNextWave(5);
      return;
    }

    if (difficulty == 4)
    {
      spawner.SpawnThreeEnemies(
        enemyScene: spawner.downWaitEnemyScene,
        scoreValue: 2,
        option: 1
      );
      spawner.TimeForNextWave(5);
      return;
    }

    if (difficulty == 5)
    {
      spawner.SpawnOneEnemy(
        enemyScene: spawner.speedEnemyScene,
        scoreValue: 3,
        option: 3
      );
      spawner.TimeForNextWave(5);
      return;
    }

    if (difficulty < 30)
    {
      int option = GenericRandom.Int(max: 2);

      switch (option)
      {
        case 0:
          spawner.SpawnOneEnemy(
            enemyScene: spawner.downEnemyScene,
            scoreValue: 3
          );
          spawner.TimeForNextWave(4);
          break;

        case 1:
          spawner.SpawnTwoEnemies(
            enemyScene: spawner.downWaitEnemyScene,
            scoreValue: 2
          );
          spawner.TimeForNextWave(5);
          break;


        case 2:
          spawner.SpawnThreeEnemies(
            enemyScene: spawner.downWaitEnemyScene,
            scoreValue: 2
          );
          spawner.TimeForNextWave(6);
          break;
      }
      return;
    }

    if (difficulty < 50)
    {
      switch (GenericRandom.Int(max: 9))
      {
        case 0:
          spawner.SpawnTwoEnemies(
            enemyScene: spawner.downEnemyScene,
            scoreValue: 3
          );
          spawner.TimeForNextWave(5);
          break;

        case 1:
          spawner.SpawnThreeEnemies(
            enemyScene: spawner.downEnemyScene,
            scoreValue: 3
          );
          spawner.TimeForNextWave(5);
          break;

        case 2:
          spawner.SpawnFourEnemies(
            enemyScene: spawner.downEnemyScene,
            scoreValue: 4
          );
          spawner.TimeForNextWave(5);
          break;

        case 3:
          spawner.SpawnOneEnemy(
            enemyScene: spawner.speedEnemyScene,
            scoreValue: 2
          );
          spawner.TimeForNextWave(4);
          break;

        case 4:
          spawner.SpawnTwoEnemies(
            enemyScene: spawner.speedEnemyScene,
            scoreValue: 3
          );
          spawner.TimeForNextWave(4);
          break;

        case 5:
          spawner.SpawnFourEnemies(
            enemyScene: spawner.speedEnemyScene,
            scoreValue: 5
          );
          spawner.TimeForNextWave(3);
          break;

        case 6:
          spawner.SpawnFourEnemies(
            enemyScene: spawner.downEnemyScene,
            scoreValue: 6
          );
          spawner.TimeForNextWave(5);
          break;

        case 7:
          spawner.SpawnFiveEnemies(
            enemyScene: spawner.downWaitEnemyScene,
            scoreValue: 3
          );
          spawner.TimeForNextWave(5);
          break;

        case 8:
          spawner.SpawnFiveEnemies(
            enemyScene: spawner.speedEnemyScene,
            scoreValue: 5
          );
          spawner.TimeForNextWave(5);
          break;

        case 9:
          spawner.SpawnFiveEnemies(
            enemyScene: spawner.downEnemyScene,
            scoreValue: 6
          );
          spawner.TimeForNextWave(5);
          break;
      }
      return;
    }

    if (difficulty >= 50)
    {
      int randEnemy = GenericRandom.Int(max: 2);
      int randSpawn = GenericRandom.Int(max: 4);

      PackedScene enemy = null;
      float timer = 0f;

      switch (randEnemy)
      {
        case 0:
          enemy = spawner.downWaitEnemyScene;
          timer = 7;
          break;
        case 1:
          enemy = spawner.downEnemyScene;
          timer = 7;
          break;
        case 2:
          enemy = spawner.speedEnemyScene;
          timer = 5;
          break;
      }

      switch (randSpawn)
      {
        case 0:
          spawner.SpawnTwoEnemies(
            enemyScene: enemy,
            scoreValue: 4 + randEnemy
          );
          break;

        case 1:
          spawner.SpawnThreeEnemies(
            enemyScene: enemy,
            scoreValue: 6 + randEnemy
          );
          break;

        case 2:
          spawner.SpawnFourEnemies(
            enemyScene: enemy,
            scoreValue: 8 + randEnemy
          );
          break;

        case 3:
          spawner.SpawnFiveEnemies(
            enemyScene: enemy,
            scoreValue: 10 + randEnemy
          );
          break;
      }

      spawner.TimeForNextWave(timer);
      return;
    }
  }

  public void OnUpdateScore(int enemyScore)
  {
    score += enemyScore;
    EmitSignal(nameof(Main.ScoreChange), score);
  }
}
