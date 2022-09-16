using Godot;
using System;

public class Background : Node2D
{
  [Export] PackedScene cloudScene;

  public Timer cloudColdown;

  private Vector2 screenSize;

  public override void _Ready()
  {
    cloudColdown = GetNode<Timer>("CloudColdown");
    cloudColdown.Connect("timeout", this, nameof(Background.SpawnCloud));

    screenSize = GetViewport().Size;
  }

  public void SpawnCloud()
  {
    int cloudAmount = GenericRandom.Int(min: 1, max: 2);
    float interval = GenericRandom.Float(max: 1f);

    for (int i = 0; i <= cloudAmount; i++)
    {
      Cloud cloud = cloudScene.Instance<Cloud>();
      cloud.Position = new Vector2(
        x: GenericRandom.Int(max: 120),
        y: -10
      );
      AddChild(cloud);
    }

    cloudColdown.Start(interval);
  }
}
