using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace testing_dotnet_7.Models
{
    public class Character
    {
        public int Id { get; set; }
        public string Name { get; set; } = "Something";
        public int HitPoints { get; set; } = 10;
        public int Attack { get; set; } = 10;
        public int Defense { get; set; } = 10;
        public RpgClass CharClass { get; set; } = RpgClass.Knight;
    }
}