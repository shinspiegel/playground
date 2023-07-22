using Godot;
using Godot.Collections;

public partial class Player : CharacterBody2D
{
	public PlayerData Data;
	public PlayerInput Input;
	public PlayerAnimPlyer Anim;
	public StateManager StateManager;

	// Used for current frame changes, applied in the `ApplyMove`
	private Vector2 velocity = Vector2.Zero;
	private bool isFlip = false;
	private string nextState = null;

	public override void _Ready()
	{
		base._Ready();
		Data = GetNode<PlayerData>("PlayerData");
		Input = GetNode<PlayerInput>("PlayerInput");
		Anim = GetNode<PlayerAnimPlyer>("PlayerAnimPlyer");
		StateManager = GetNode<StateManager>("StateManager");

		StateManager.StateFinished += OnStateEnd;
	}

	public override void _PhysicsProcess(double delta)
	{
		CleanNextState();
		StateManager.Apply(delta);

		// applyGravity((float)delta);
		// checkJump();
		// applyDirection();
		// applyFlip();

		ApplyMove();

		StateUpdate();
	}

	public void ApplyFlip()
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

	public void ApplyDirection(float direction = 0.0f, float ratio = 1.0f)
	{
		if (direction != 0.0f)
		{
			velocity.X = (direction * Data.Speed) * ratio;
		}
		else
		{
			velocity.X = Mathf.MoveToward(Velocity.X, 0, (Data.Speed * ratio));
		}
	}

	public void ApplyJumpForce()
	{
		velocity.Y = Data.JumpVelocity;
	}

	public void ApplyGravity(float delta)
	{
		if (!IsOnFloor())
		{
			velocity.Y += Data.gravity * delta;
		}
	}

	public void ApplyMove()
	{
		Velocity = velocity;
		MoveAndSlide();
	}

	private void CleanNextState()
	{
		nextState = null;
	}

	private void StateUpdate()
	{
		bool shouldFall = Velocity.Y > 0;
		bool shouldLand = Velocity.Y == 0 && StateManager.CurrentName() == "Falling";
		bool shouldMove = Input.moveDir != 0 && IsOnFloor();
		bool shouldJump = Input.isJumping && IsOnFloor();

		if (nextState == null && shouldFall) { nextState = "Falling"; }
		if (nextState == null && shouldLand) { nextState = "Landing"; }
		if (nextState == null && shouldJump) { nextState = "Jump"; }
		if (nextState == null && shouldMove) { nextState = "Move"; }
		if (nextState == null) { nextState = "Idle"; }

		if (nextState != null) { StateManager.Change(nextState); }
	}

	private void OnStateEnd(string state)
	{
		if (state == "Landing") { nextState = "Idle"; }
	}
}
