using Godot;
using System;

public class LevelManager : Node2D
{
  [Export] public PackedScene playerScene;
  [Export] public NodePath startPosition;

  public LightSource lastCheckpoint;
  public Camera2D camera;
  public HUD hud;
  private PackedScene gameOverScreen;

  public override void _Ready()
  {
    gameOverScreen = ResourceLoader.Load<PackedScene>("res://Scenes/GameOver.tscn");
    lastCheckpoint = GetNode<LightSource>(startPosition);
    lastCheckpoint.Activate();

    camera = GetNode<Camera2D>("Camera");
    hud = GetNode<HUD>("HUD");

    StartGame();
  }

  public void UpdateCheckpoint(LightSource checkpoint)
  {
    if (checkpoint != lastCheckpoint)
    {
      lastCheckpoint.Deactivate();
      lastCheckpoint = checkpoint;
      lastCheckpoint.Activate();
    }
  }

  private void OnPlayerDeath()
  {
    StartGame();
  }

  private void StartGame()
  {
    Player player = playerScene.Instance<Player>();
    NodePath cameraPath = camera.GetPath();

    player.GlobalPosition = lastCheckpoint.GlobalPosition;
    player.levelManager = this;
    player.Connect(nameof(Player.OnUpdateBattery), hud, nameof(HUD.UpdateBateryLevel));
    player.Connect(nameof(Player.OnDie), this, nameof(LevelManager.OnPlayerDeath));

    AddChild(player);

    player.SetCameraOnRig(cameraPath);
  }

  public void FinishLine(Node2D body)
  {
    if (body is Player)
    {
      GetTree().ChangeSceneTo(gameOverScreen);
    }
  }
}
