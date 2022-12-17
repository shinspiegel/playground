using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using testing_dotnet_7.Models;
using testing_dotnet_7.Services.CharacterService;

namespace testing_dotnet_7.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class CharacterController : ControllerBase
    {
        private readonly ICharacterService _charService;

        public CharacterController(ICharacterService charService)
        {
            _charService = charService;
        }

        [HttpGet("GetAll")]
        public async Task<ActionResult<ServiceResponse<List<Character>>>> GetAll()
        {
            return Ok(await _charService.GetAll());
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<ServiceResponse<Character>>> GetSingle(int id)
        {
            return Ok(await _charService.GetById(id));
        }

        [HttpPost()]
        public async Task<ActionResult<ServiceResponse<Character>>> Create(Character character)
        {
            return Ok(await _charService.AddCharacter(character));
        }
    }
}