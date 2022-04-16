using Godot;
using System;
using System.Collections.Generic;

namespace Screens
{
  public class ScreenAutoFinish : Node
  {
    [Export] float maxScreenTime = 5f;
    [Export] PackedScene nextScene;
    [Export] List<string> keysToWatch = new List<string> { "ui_cancel", "ui_accept", "jump" };

    public Timer timer;

    public override void _Ready()
    {
      base._Ready();
      timer = GetNode<Timer>("Timer");
      timer.Connect("timeout", this, nameof(ScreenAutoFinish.OnTimeout));
      timer.Start(maxScreenTime);
    }

    public override void _UnhandledInput(InputEvent inputEvent)
    {
      base._UnhandledInput(inputEvent);

      keysToWatch.ForEach((key) =>
      {
        if (inputEvent.IsAction(key)) { ChangeScene(); }
      });
    }

    public void OnTimeout()
    {
      ChangeScene();
    }

    public void ChangeScene()
    {
      GetTree().ChangeSceneTo(nextScene);
    }
  }
}