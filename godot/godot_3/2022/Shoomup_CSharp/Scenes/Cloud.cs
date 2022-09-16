using Godot;
using System;

public class Cloud : Node2D
{
  [Export] public int speed = 100;

  public Sprite cloudSprite;
  public VisibilityNotifier2D notifier;
  public float randAmount = GenericRandom.Float();

  public override void _Ready()
  {
    notifier = GetNode<VisibilityNotifier2D>("VisibilityNotifier2D");
    notifier.Connect("screen_exited", this, nameof(Cloud.OnExitScreen));

    cloudSprite = GetNode<Sprite>("Sprite");
    cloudSprite.Frame = GenericRandom.Int(max: cloudSprite.Hframes - 1);

    speed = (int)Mathf.Clamp(speed * randAmount, 20, 100);

    ZIndex = -99;
    ZIndex += Mathf.Clamp((int)(100 * randAmount), 0, 98);

    Modulate = new Color(
      r: 1f,
      g: 1f,
      b: 1f,
      a: Mathf.Clamp(randAmount, 0.2f, 0.8f)
    );

    Scale = new Vector2(
      x: Mathf.Clamp(1 * randAmount, 0.4f, 1f),
      y: Mathf.Clamp(1 * randAmount, 0.4f, 1f)
    );
  }

  public override void _Process(float delta)
  {
    Position = new Vector2(
      x: Position.x,
      y: Position.y + (speed * delta)
    );
  }

  public void OnExitScreen()
  {
    QueueFree();
  }
}
