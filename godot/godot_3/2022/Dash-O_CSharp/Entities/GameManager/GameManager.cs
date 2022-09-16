using GameUI;
using Godot;
using System;

namespace Entities
{
  public class GameManager : Node2D
  {
    [Export] public bool usePersistentTime = true;
    [Export] public NodePath playerPath;
    [Export] public NodePath uiPath;
    [Export] public NodePath internalClockPath;
    [Export] public NodePath levelPath;

    public Player.Player player;
    public UI ui;
    public InternalClock internalClock;
    public Levels.Level level;

    public override void _Ready()
    {
      base._Ready();
      SetupAllNodes();
      SetupInternalClock();
      SetupPlayer();
    }

    private void SetupAllNodes()
    {
      ui = GetNode<UI>(uiPath);
      internalClock = GetNode<InternalClock>(internalClockPath);
      player = GetNode<Player.Player>(playerPath);
      level = GetNode<Levels.Level>(levelPath);
    }

    private void SetupInternalClock()
    {
      internalClock.Connect(
        nameof(InternalClock.TimeChanged),
        ui,
        nameof(UI.ChangeTimeDisplay)
      );

      internalClock.Connect(
        nameof(InternalClock.OutOfTime),
        level,
        nameof(Levels.Level.OnLevelTimeout)
      );

      Utils.GameData data = Utils.GamePersistance.LoadData();

      if (usePersistentTime)
      {
        data = Utils.GamePersistance.LoadData();
      }
      else
      {
        data = new Utils.GameData();
      }

      internalClock.SetTime(data.minutes, data.seconds);
    }

    private void SetupPlayer()
    {
      player.Connect(
        nameof(Player.Player.HitPointsChanged),
        ui,
        nameof(UI.OnHitPointChanged)
      );

      player.Connect(
        nameof(Player.Player.PlayerDied),
        level,
        nameof(Levels.Level.OnPlayerDied)
      );
    }
  }
}