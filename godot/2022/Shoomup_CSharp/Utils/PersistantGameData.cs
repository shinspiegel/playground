using Godot;
using System;

public static class PersistentGameData
{
  private static string saveFile = "user://buffer";

  public static void SaveScore(int score)
  {
    var file = new File();
    file.Open(saveFile, File.ModeFlags.Write);
    file.StoreString($"{score}");
    file.Close();
  }

  public static int LoadScore()
  {
    var file = new File();

    if (file.FileExists(saveFile))
    {
      file.Open(saveFile, File.ModeFlags.Read);
      string data = file.GetAsText();
      file.Close();

      return Int32.Parse(data);
    }

    return 0;
  }
}