using DestinyLimoServer.Common.Repository;
using DestinyLimoServer.Models;

namespace DestinyLimoServer.Repositories
{
    public interface IMaterialRepository<T>
    {
        Task<IEnumerable<T>> GetAllMaterials(bool inactive = true, bool deleted = false, bool is_public = false);
        Task<T?> GetMaterialById(int MaterialId);
        Task<T> GetMaterialByMaterialName(string Materialname);
        Task<IEnumerable<T>> GetRandomQuestions(int numQuestions);
        Task<int> AddMaterialAsync(T material,  string[]? cols = null);
        Task<bool> UpdateMaterialAsync(T material, string[]? cols = null);
        Task<bool> DeleteSoftMaterialAsync(T material);
        Task<bool> DeleteMaterialAsync(T material);
    }
}