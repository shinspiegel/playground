using Godot;
using System;

public class Mob : RigidBody2D
{
  [Export]
  public int MinSpeed = 150;
  [Export]
  public int MaxSpeed = 250;

  private AnimatedSprite animatedSprite;

  static private Random random = new Random();

  public override void _Ready()
  {
    animatedSprite = GetNode<AnimatedSprite>("AnimatedSprite");
    var mobTypes = animatedSprite.Frames.GetAnimationNames();
    animatedSprite.Animation = mobTypes[random.Next(0, mobTypes.Length)];
  }

  public void OnVisibilityNotifier2DScreenExited()
  {
    QueueFree();
  }
}
