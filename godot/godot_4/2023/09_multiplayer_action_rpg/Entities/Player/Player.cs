using Godot;
using Godot.Collections;

public partial class Player : CharacterBody2D
{
	[Export] public PlayerData data;
	[Export] public Camera2D gameCamera;

	public PlayerInput input;
	public PlayerAnimPlyer anim;
	public StateManager stateManager;
	public RemoteTransform2D remoteTransform;
	public HurtBox hurtBox;

	// Used for current frame changes, applied in the `ApplyMove`
	private Vector2 velocity = Vector2.Zero;
	private bool isFlip = false;

	public override void _Ready()
	{
		base._Ready();

		input = GetNode<PlayerInput>("PlayerInput");
		anim = GetNode<PlayerAnimPlyer>("PlayerAnimPlyer");

		stateManager = GetNode<StateManager>("StateManager");
		stateManager.StateFinished += OnStateEnd;

		remoteTransform = GetNode<RemoteTransform2D>("RemoteTransform2D");
		remoteTransform.RemotePath = gameCamera.GetPath();

		hurtBox = GetNode<HurtBox>("HurtBox");
		hurtBox.Hit += OnHit;
	}

	public override void _PhysicsProcess(double delta)
	{
		stateManager.Apply(delta);
		ApplyMove();
	}

	public int GetFacing()
	{
		return !isFlip ? 1 : -1;
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
			velocity.X = (direction * data.speed) * ratio;
		}
		else
		{
			velocity.X = Mathf.MoveToward(Velocity.X, 0, (data.speed * ratio));
		}
	}

	public void ApplyJumpForce(float ratio = 1.0f)
	{
		velocity.Y = (data.jumpForce) * ratio;
	}

	public void ApplyGravity(float delta, float ratio = 1.0f)
	{
		if (!IsOnFloor())
		{
			velocity.Y += (data.gravity * delta) * ratio;
		}
	}

	public void ApplyMove()
	{
		Velocity = velocity;
		MoveAndSlide();
	}

	private void OnStateEnd(string state)
	{
		string nextState = null;

		if (state == "Idle")
		{
			if (input.moveDir != 0.0f) { nextState = "Move"; }
			if (input.isJumping) { nextState = "Jump"; }
			if (input.isRoll) { nextState = "Roll"; }
		}

		if (state == "Move")
		{
			nextState = "Idle";
			if (input.isJumping) { nextState = "Jump"; }
			if (input.isRoll) { nextState = "Roll"; }
		}

		if (state == "Jump")
		{
			nextState = "Falling";
		}

		if (state == "Falling")
		{
			nextState = "Landing";
			if (input.moveDir != 0.0f) { nextState = "Move"; }
		}

		if (state == "Landing")
		{
			nextState = "Idle";
			if (input.moveDir != 0.0f) { nextState = "Move"; }
			if (input.isJumping) { nextState = "Jump"; }
			if (input.isRoll) { nextState = "Roll"; }
		}

		if (state == "Roll")
		{
			nextState = "Idle";
		}

		if (nextState != null)
		{
			stateManager.Change(nextState);
		}
	}

	private void OnHit()
	{
		GD.Print($"[{Name}]::Hit");
	}
}
