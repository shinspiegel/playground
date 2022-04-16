using Godot;
using System;
using Godot.Collections;

namespace Entities.Player
{
  public class Roll : PlayerState
  {
    [Export] public float RollPower = 0.8f;
    [Export] public NodePath animationPlayerPath;
    [Export] public NodePath topFrontPath;
    [Export] public NodePath topBackPath;
    [Export] public NodePath colliderPath;
    [Export] public NodePath hurtBoxPath;

    public AnimationPlayer animationPlayer;
    public RayCast2D topFront;
    public RayCast2D topBack;
    public CollisionShape2D standUpCollider;
    public HurtBox hurtBox;

    public override void _Ready()
    {
      base._Ready();
      SetupAnimationPlayer();
      SetupRollRayTopCheck();
      SetupColliderPath();
      SetupHurtBox();
    }

    public override void OnProccess(float delta)
    {
      base.OnProccess(delta);
      player.movement.ApplyHorizontalForce(player, player.movement.facingDirection, RollPower);
    }

    public override void OnEnter()
    {
      base.OnEnter();
      player.animationPlayer.Play(player.animationList.roll);
      standUpCollider.Disabled = true;
      hurtBox.Desactive();
    }

    public override void OnExit()
    {
      base.OnExit();
      standUpCollider.Disabled = false;
      hurtBox.Active();
    }

    // Being called from the animation tree
    public void CheckFinishAnimation()
    {
      if (IsTopFree())
      {
        ChangeState(player.stateList.idle);
      }
    }

    private bool IsTopFree()
    {
      if (topFront.IsColliding() || topBack.IsColliding())
      {
        return false;
      }

      return true;
    }

    private void SetupAnimationPlayer()
    {
      animationPlayer = GetNode<AnimationPlayer>(animationPlayerPath);
    }

    private void SetupRollRayTopCheck()
    {
      topFront = GetNode<RayCast2D>(topFrontPath);
      topBack = GetNode<RayCast2D>(topBackPath);
    }

    private void SetupColliderPath()
    {
      standUpCollider = GetNode<CollisionShape2D>(colliderPath);
    }

    private void SetupHurtBox()
    {
      hurtBox = GetNode<HurtBox>(hurtBoxPath);
    }
  }
}