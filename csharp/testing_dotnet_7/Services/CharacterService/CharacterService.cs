using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using testing_dotnet_7.Dtos.Characters;
using testing_dotnet_7.Models;

namespace testing_dotnet_7.Services.CharacterService
{
    public class CharacterService : ICharacterService
    {
        private readonly IMapper _mapper;

        private static List<Character> characters = new List<Character> {
            new Character {Id = 0, Name = "Gil"},
            new Character {Id = 1, Name = "Shin"},
            new Character {Id = 2, Name = "Other"},
        };

        public CharacterService(IMapper mapper)
        {
            _mapper = mapper;
        }

        public async Task<ServiceResponse<GetCharacterDto>> AddCharacter(CreateCharacterDto character)
        {
            var response = new ServiceResponse<Character>();
            characters.Add(_mapper.Map<Character>(character));
            response.data = null;
            return response;
        }

        public async Task<ServiceResponse<List<GetCharacterDto>>> GetAll()
        {
            var response = new ServiceResponse<List<Character>>();
            response.data = characters.Select(c => _mapper.Map<GetCharacterDto>(c)).ToList();
            return response;
        }

        public async Task<ServiceResponse<GetCharacterDto>> GetById(int id)
        {
            var response = new ServiceResponse<Character>();
            response.data = characters.FirstOrDefault(c => c.Id == id);
            return response;
        }

        public async Task<ServiceResponse<GetCharacterDto>> RemoveById(int id)
        {
            throw new NotImplementedException();
        }

        public async Task<ServiceResponse<GetCharacterDto>> UpdateById(int id)
        {
            throw new NotImplementedException();
        }
    }
}