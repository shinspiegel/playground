using Godot;
using System;

public class Shoot : Area2D
{
  [Export] public int velocity = 50;
  [Export] public bool shootDown = true;

  public Damage damage = new Damage();

  public override void _Ready()
  {
    GetNode<VisibilityNotifier2D>("VisibilityNotifier2D").Connect("screen_exited", this, nameof(Shoot.Clean));
    Connect("body_entered", this, nameof(Shoot.OnHitTarget));
  }

  public override void _PhysicsProcess(float delta)
  {
    int multiplier = shootDown ? -1 : 1;

    Position = new Vector2(
      y: Position.y - ((velocity * delta) * multiplier),
      x: Position.x
    );
  }

  public virtual void OnHitTarget(Node body)
  {
    if (body is Actor)
    {
      Actor actor = (Actor)body;
      actor.TakeDamage(damage);
      QueueFree();
    }
  }

  private void Clean()
  {
    QueueFree();
  }
}
