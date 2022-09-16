using Godot;
using System;
using System.Threading.Tasks;

namespace Utils
{
  public static class Wait
  {
    async public static Task For(float time, Godot.Node target)
    {
      Timer timer = new Timer();
      target.AddChild(timer);
      timer.Start(time);
      await timer.ToSignal(timer, "timeout");
      target.RemoveChild(timer);
    }
  }
}