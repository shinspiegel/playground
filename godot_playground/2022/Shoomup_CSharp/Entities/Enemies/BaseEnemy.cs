using Godot;
using System;

public class BaseEnemy : Actor
{
  [Signal] public delegate void UpdateScore(int scoreValue);

  [Export] public int downSpeed = 20;
  [Export] public PackedScene deathAnimationScene;
  [Export] public Godot.Collections.Array<EntityInput> listInputs;

  public Timer currentActionTimer;

  public int actionHead = 0;
  public int scoreValue = 0;

  public override void _Ready()
  {
    base._Ready();
    currentActionTimer = GetNode<Timer>("CurrentActionTimer");
    actionHead = 0;
  }

  public override void _PhysicsProcess(float delta)
  {
    base._PhysicsProcess(delta);
    ApplyActor();
    ApplyAnimation();
  }

  public void ApplyAnimation()
  {
    var action = animationPlayer.CurrentAnimation;

    if (input.direction.x == 0 || input.direction.y == 0) { action = "Idle"; }
    if (input.direction.x != 0 || input.direction.y != 0) { action = "Move"; }
    if (input.shoot) { action = "Shoot"; }

    if (animationPlayer.CurrentAnimation != action)
    {
      animationPlayer.Play(action);
    }
  }

  public override void ApplyDirectionalForce()
  {
    base.ApplyDirectionalForce();

    if (input.direction.y != 0)
    {
      velocity.y = downSpeed * input.direction.y;
    }
    else
    {
      velocity.y = 0;
    }
  }

  public override void GetUserInput()
  {
    if (listInputs.Count > 0 && currentActionTimer.TimeLeft == 0)
    {

      input = listInputs[actionHead];
      currentActionTimer.Start(input.holdFor);

      if (actionHead + 1 < listInputs.Count)
      {
        actionHead += 1;
      }
    }
  }

  public void OnTouchPlayer(Node body)
  {
    if (body is Player)
    {
      var player = body as Player;
      Damage dmg = new Damage(1);
      player.TakeDamage(dmg);
      TakeDamage(dmg);
    }
  }

  public override void Die()
  {
    EmitSignal(nameof(BaseEnemy.UpdateScore), scoreValue);

    var deathAnimation = deathAnimationScene.Instance<BaseEffect>();
    deathAnimation.GlobalPosition = GlobalPosition;
    GetParent().AddChild(deathAnimation);

    base.Die();
  }

  public void OnExitScreen() { QueueFree(); }
}
