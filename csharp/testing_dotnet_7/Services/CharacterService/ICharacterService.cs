using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using testing_dotnet_7.Dtos.Characters;
using testing_dotnet_7.Models;

namespace testing_dotnet_7.Services.CharacterService
{
    public interface ICharacterService
    {
        Task<ServiceResponse<List<GetCharacterDto>>> GetAll();
        Task<ServiceResponse<GetCharacterDto>> GetById(int id);
        Task<ServiceResponse<GetCharacterDto>> AddCharacter(CreateCharacterDto character);
        Task<ServiceResponse<GetCharacterDto>> RemoveById(int id);
        Task<ServiceResponse<GetCharacterDto>> UpdateById(int id);
    }
}