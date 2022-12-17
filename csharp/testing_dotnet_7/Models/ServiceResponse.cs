using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace testing_dotnet_7.Models
{
    public class ServiceResponse<DATA>
    {
        public DATA? data { get; set; }
        public bool status { get; set; } = true;
        public string message { get; set; } = string.Empty;
    }
}