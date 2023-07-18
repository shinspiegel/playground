using Godot;

public partial class Player : CharacterBody2D
{
    [Export] public PlayerData Data;
    [Export] public PlayerInput Input;
    [Export] public AnimationPlayer Anim;

    private Vector2 velocity = Vector2.Zero;
	private bool isFlip = false;

    public override void _PhysicsProcess(double delta)
    {
        applyGravity((float)delta);
        checkJump();
        applyDirection();
        applyFlip();
        applyMove();
    }

    private void applyFlip()
    {
        if (!isFlip && velocity.X < 0)
        {
            Scale = new Vector2(-1, 1);
			Rotation = 0;
			isFlip = true;
        }
		else if (isFlip && velocity.X > 0)
		{
            Scale = new Vector2(1, 1);
			Rotation = 0;
			isFlip = false;
		}
    }

    private void applyDirection()
    {
        if (Input.Direction != Vector2.Zero)
        {
            velocity.X = Input.Direction.X * Data.Speed;
            Anim.Play("run");
        }
        else
        {
            velocity.X = Mathf.MoveToward(Velocity.X, 0, Data.Speed);
            Anim.Play("idle");
        }
    }

    private void checkJump()
    {
        if (Input.IsJumping && IsOnFloor())
        {
            velocity.Y = Data.JumpVelocity;
        }
    }

    private void applyGravity(float delta)
    {
        if (!IsOnFloor())
        {
            velocity.Y += Data.gravity * delta;
        }
    }

    private void applyMove()
    {
        Velocity = velocity;
        MoveAndSlide();
    }
}
