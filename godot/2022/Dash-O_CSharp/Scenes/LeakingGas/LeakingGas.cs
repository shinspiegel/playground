using Godot;
using System;

namespace Scenes
{
  public class LeakingGas : Node2D
  {
    [Export] float waitTime = 1f;
    [Export] float delayOnFirst = 0f;

    private Timer timer;
    private AnimationPlayer animationPlayer;

    public override void _Ready()
    {
      base._Ready();
      timer = GetNode<Timer>("Timer");
      animationPlayer = GetNode<AnimationPlayer>("AnimationPlayer");

      animationPlayer.Connect(
        "animation_finished",
        this,
        nameof(LeakingGas.OnAnimationFinished)
      );

      timer.Connect(
        "timeout",
        this,
        nameof(LeakingGas.OnTimeOut)
      );

      Start(delayOnFirst);
    }

    public void OnTimeOut()
    {
      animationPlayer.Play("LeakGas");
    }

    public void OnAnimationFinished(string anim)
    {
      if (anim == "LeakGas")
      {
        Start();
      }
    }

    private void Start(float delay = 0f)
    {
      if (waitTime > 0)
      {
        animationPlayer.Play("Idle");
        timer.Start(waitTime + delay);
      }
    }
  }
}