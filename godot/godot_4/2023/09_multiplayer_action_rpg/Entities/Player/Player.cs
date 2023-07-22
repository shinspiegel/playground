using Godot;

public partial class Player : CharacterBody2D
{
	public PlayerData Data;
	public PlayerInput Input;
	public PlayerAnimPlyer Anim;
	public StateManager StateManager;

	// Used for current frame changes, applied in the `ApplyMove`
	private Vector2 velocity = Vector2.Zero;
	private bool isFlip = false;

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

	public void ApplyDirection()
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

	public void CheckJump()
	{
		if (Input.IsJumping && IsOnFloor())
		{
			velocity.Y = Data.JumpVelocity;
		}
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

	private void StateUpdate()
	{
		string nextState = null;
		bool isFalling = Velocity.Y > 0;
		bool isLanding = Velocity.Y == 0 && StateManager.CurrentName() == "Falling";
		bool isInputMove = Input.Direction.X != 0;

		if (isFalling) { nextState = "Falling"; }
		if (isLanding) { nextState = "Landing"; }

		if (nextState != null) { StateManager.Change(nextState); }
	}

	private void OnStateEnd(string state)
	{
		GD.Print(state);
	}
}
