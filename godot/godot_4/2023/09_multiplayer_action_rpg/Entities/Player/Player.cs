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
	private string nextState = null;

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
		CleanNextState();
		stateManager.Apply(delta);
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

	private void CleanNextState()
	{
		nextState = null;
	}

	private void StateUpdate()
	{
		bool shouldMove = input.moveDir != 0 && IsOnFloor();
		bool shouldIdle = input.moveDir == 0 && Velocity.X == 0 && IsOnFloor();
		bool shouldFall = Velocity.Y > 0 && !IsOnFloor();
		bool shouldLand = Velocity.Y == 0 && stateManager.CurrentName() == "Falling";
		bool shouldJump = input.isJumping && IsOnFloor();

		if (nextState == null && shouldFall) { nextState = "Falling"; }
		if (nextState == null && shouldLand) { nextState = "Landing"; }
		if (nextState == null && shouldJump) { nextState = "Jump"; }
		if (nextState == null && shouldMove) { nextState = "Move"; }
		if (nextState == null && shouldIdle) { nextState = "Idle"; }

		if (nextState != null) { stateManager.Change(nextState); }
	}

	private void OnStateEnd(string state)
	{
		if (state == "Landing") { nextState = "Idle"; }
	}

	private void OnHit()
	{
		GD.Print($"[{Name}]::Hit");
	}
}
