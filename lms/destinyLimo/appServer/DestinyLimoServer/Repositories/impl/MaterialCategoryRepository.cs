using DestinyLimoServer.Common.DB;
using DestinyLimoServer.Common.Repository;
using DestinyLimoServer.Models;

namespace DestinyLimoServer.Repositories.impl
{
    public class MaterialCategoryRepository(DapperContext dapperContext) : BaseRepository<MaterialCategory>(dapperContext, "training_material_category", "material_category_id"), IMaterialCategoryRepository
    {
        public async Task<IEnumerable<MaterialCategory>> GetAllMaterialCategories(bool inactive = true, bool is_deleted = false)
        {
            return await GetAllAsync(inactive, is_deleted);
        }

        public async Task<MaterialCategory> GetMaterialCategoryById(int MaterialCategoryId)
        {
            return await GetByIdAsync(MaterialCategoryId);
        }

        public async Task<MaterialCategory> GetMaterialCategoryByMaterialCategoryname(string MaterialCategoryname)
        {
            return await QueryFirstOrDefaultAsync("SELECT * FROM training_material_category WHERE material_category_name = @MaterialCategoryname", new { MaterialCategoryname = MaterialCategoryname });
        }
    }
}