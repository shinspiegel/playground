using Godot;
using System;

public class Main : Node
{
  [Export]
  public PackedScene Mob;

  private int score;
  private Random random = new Random();
  private Position2D startPosition;
  private Player player;
  private Timer startTimer;
  private Timer mobTimer;
  private Timer scoreTimer;
  private PathFollow2D mobSpawnLocation;
  private HUD hud;
  private AudioStreamPlayer music;
  private AudioStreamPlayer deathSound;

  public override void _Ready()
  {
    startPosition = GetNode<Position2D>("StartPosition");
    player = GetNode<Player>("Player");
    startTimer = GetNode<Timer>("StartTimer");
    mobTimer = GetNode<Timer>("MobTimer");
    scoreTimer = GetNode<Timer>("ScoreTimer");
    mobSpawnLocation = GetNode<PathFollow2D>("MobPath/MobSpawnLocation");
    hud = GetNode<HUD>("HUD");
    music = GetNode<AudioStreamPlayer>("Music");
    deathSound = GetNode<AudioStreamPlayer>("DeathStream");
  }

  private float RandRange(float min, float max)
  {
    return (float)random.NextDouble() * (max - min) + min;
  }

  public void NewGame()
  {
    score = 0;
    player.Start(startPosition.Position);
    startTimer.Start();

    hud.UpdateScore(score);
    hud.ShowMessage("Get Ready!");

    music.Play();
  }

  public void GameOver()
  {
    mobTimer.Stop();
    scoreTimer.Stop();

    hud.ShowGameOver();
    GetTree().CallGroup("mobs", "queue_free");

    deathSound.Play();
  }

  public void OnStartTimerTimeout()
  {
    mobTimer.Start();
    scoreTimer.Start();
  }

  public void OnScoreTimerTimeout()
  {
    score++;

    hud.UpdateScore(score);
  }

  public void OnMobTimerTimeout()
  {
    mobSpawnLocation.Offset = random.Next();

    RigidBody2D mobInstance = (RigidBody2D)Mob.Instance();

    AddChild(mobInstance);

    float direction = mobSpawnLocation.Rotation + Mathf.Pi / 2;

    mobInstance.Position = mobSpawnLocation.Position;

    direction += RandRange(-Mathf.Pi / 4, Mathf.Pi / 4);
    mobInstance.Rotation = direction;
    mobInstance.LinearVelocity = new Vector2(RandRange(150f, 250f), 0).Rotated(direction);
  }
}
