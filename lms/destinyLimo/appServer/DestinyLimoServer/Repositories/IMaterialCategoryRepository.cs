using DestinyLimoServer.Models;

namespace DestinyLimoServer.Repositories
{
    public interface IMaterialCategoryRepository
    {
        Task<IEnumerable<MaterialCategory>> GetAllMaterialCategories(bool inactive = true, bool deleted = false);
        Task<MaterialCategory> GetMaterialCategoryById(int MaterialCategoryId);
        Task<MaterialCategory> GetMaterialCategoryByMaterialCategoryname(string MaterialCategoryname);

        Task<int> AddAsync(MaterialCategory entity, string[]? cols = null);
        Task<bool> UpdateAsync(MaterialCategory entity, int id, string[]? cols = null);
        Task<bool> DeleteAsync(int id);
        Task<bool> DeleteSoftAsync(int id);
    }
}