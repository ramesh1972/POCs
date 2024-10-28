using Dapper;
using DestinyLimoServer.Common.DB;
using DestinyLimoServer.Common.Repository;
using DestinyLimoServer.Models;
using Org.BouncyCastle.Security;

namespace DestinyLimoServer.Repositories.impl
{
    public class MaterialRepository<T>(DapperContext dapperContext) : BaseRepository<T>(dapperContext, "training_material", "material_id"), IMaterialRepository<T> where T : class
    {
        private DapperContext? _dapperContext = dapperContext;

        private string _getTableName()
        {
            Type type = typeof(T);

            if (type == typeof(MaterialText))
            {
                return "training_material_text";
            }
            else if (type == typeof(MaterialVideo))
            {
                return "training_material_videos";
            }
            else if (type == typeof(MaterialFile))
            {
                return "training_material_files";
            }
            else if (type == typeof(MaterialMCQ))
            {
                return "training_material_mcqs";
            }
            else if (type == typeof(Material))
            {
                return "training_material";
            }
            else
            {
                throw new Exception("Invalid Material Type");
            }
        }

        public async Task<IEnumerable<T>> GetAllMaterials(bool is_public, bool inactive = true, bool deleted = false)
        {

            System.Console.WriteLine("is public " + is_public);

            using var connection = CreateConnection();
            var sql = $"SELECT * FROM {_getTableName()} " +
                      $"INNER JOIN training_material ON training_material.material_id = {_getTableName()}.material_id ";

            sql += (is_public == true) ? "WHERE is_public = 1" : "WHERE is_public in (1,0)";

            if (!inactive)
            {
                sql += " AND is_active = 1";
            }

            if (!deleted)
            {
                sql += " AND is_deleted = 0";
            }

            System.Console.WriteLine("MATERIAL sql: " + sql);

            return await connection.QueryAsync<T>(sql);
        }

        public async Task<T?> GetMaterialById(int MaterialId)
        {
            var sql = $"SELECT * FROM {_getTableName()} " +
                      $"INNER JOIN training_material ON training_material.material_id = {_getTableName()}.material_id " +
                      "WHERE training_material.material_id = @MaterialId";

            var connection = CreateConnection();
            return await connection.QueryFirstOrDefaultAsync<T>(sql, new { MaterialId = MaterialId });
        }

        public Task<T> GetMaterialByMaterialName(string Materialname)
        {
            throw new NotImplementedException();
        }

        public async Task<IEnumerable<T>> GetRandomQuestions(int numQuestions)
        {
            var sql = $"SELECT * FROM {_getTableName()} " +
                      $"INNER JOIN training_material ON training_material.material_id = {_getTableName()}.material_id " +
                      $"WHERE is_active = 1 AND is_deleted = 0 " +
                      "ORDER BY RAND() LIMIT @numQuestions";

            var connection = CreateConnection();

            return await connection.QueryAsync<T>(sql, new { numQuestions = numQuestions });
        }

        public IBaseRepository<T> GetMaterialRepository(string tableName, string idColumn)
        {
            return new BaseRepository<T>(_dapperContext!, tableName, idColumn);
        }

        public async Task<int> AddMaterialAsync(T material, string[]? cols = null)
        {
            // 1st add to the training_material parent table
            Material trainingMaterial = (material as Material)!;

            // remove material_id from cols
            var material_table_cols = new string[] { "material_id", "material_type_id", "material_category_id", "is_public", "is_active", "is_deleted", "created_at", "updated_at", "title", "description", "thumbnail", "background_img" };

            var cols2 = cols?.Where(x => x != "material_id").ToArray();
            cols2 = cols2?.Where(x => material_table_cols.Contains(x)).ToArray();

            int newMaterialId = -1;
            if (cols2 != null && cols2.Length > 0)
            {
                IBaseRepository<Material> repo = new BaseRepository<Material>(_dapperContext!, "training_material", "material_id");
                newMaterialId = await repo.AddAsync(trainingMaterial, cols2);
            }

            var material_pk_id = -1;

            // 2nd add to the specific material table
            // remove all training_material cols from cols
            var cols3 = cols?.Where(x => !material_table_cols.Contains(x)).ToArray();
    
            var tableName = _getTableName();

            if (cols3 == null || cols3.Length == 0)
            {
                return newMaterialId;
            }

            // add material_id to cols
            cols3 = [.. cols3, "material_id"];

            if (tableName == "training_material_text")
            {
                IBaseRepository<MaterialText> repo2 = (IBaseRepository<MaterialText>)GetMaterialRepository("training_material_text", "text_id");
                var materialText = material as MaterialText;

                materialText!.material_id = newMaterialId;

                material_pk_id = await repo2.AddAsync(materialText, cols3);
            }
            else if (tableName == "training_material_videos")
            {
                IBaseRepository<MaterialVideo> repo2 = (IBaseRepository<MaterialVideo>)GetMaterialRepository("training_material_videos", "video_id");
                var materialVideo = material as MaterialVideo;
                materialVideo!.material_id = newMaterialId;

                if (Path.IsPathFullyQualified(materialVideo.url!))
                    materialVideo.url = Path.GetFileName(materialVideo.url);

                material_pk_id = await repo2.AddAsync(materialVideo, cols3);
            }
            else if (tableName == "training_material_files")
            {
                IBaseRepository<MaterialFile> repo2 = (IBaseRepository<MaterialFile>)GetMaterialRepository("training_material_files", "file_id");
                var materialFile = material as MaterialFile;
                materialFile!.material_id = newMaterialId;

                if (Path.IsPathFullyQualified(materialFile.file_name!))
                    materialFile.file_name = Path.GetFileName(materialFile.file_name);

                material_pk_id = await repo2.AddAsync(materialFile, cols3);
            }
            else if (tableName == "training_material_mcqs")
            {
                IBaseRepository<MaterialMCQ> repo2 = (IBaseRepository<MaterialMCQ>)GetMaterialRepository("training_material_mcqs", "question_id");
                var materialMCQ = material as MaterialMCQ;
                materialMCQ!.material_id = newMaterialId;

                material_pk_id = await repo2.AddAsync(materialMCQ, cols3);
            }
            else
            {
                throw new Exception("Invalid Material Type");
            }

            return material_pk_id;
        }

        public async Task<bool> UpdateMaterialAsync(T material, string[]? cols = null)
        {
            // first check if cols belong to training_material table and if so update only those columns
            Material trainingMaterial = (material as Material)!;

            // remove material_id from cols
            var material_table_cols = new string[] { "material_id", "material_type_id", "material_category_id", "is_public", "is_active", "is_deleted", "created_at", "updated_at", "title", "description", "thumbnail", "background_img" };

            var cols2 = cols?.Where(x => x != "material_id").ToArray();
            cols2 = cols2?.Where(x => material_table_cols.Contains(x)).ToArray();

            if (cols2 != null && cols2.Length > 0)
            {
                IBaseRepository<Material> materialRepository = new BaseRepository<Material>(_dapperContext!, "training_material", "material_id");
                await materialRepository.UpdateAsync(trainingMaterial, trainingMaterial.material_id, cols2);
            }

            // remove all training_material cols from cols
            var cols3 = cols?.Where(x => !material_table_cols.Contains(x)).ToArray();

            if (cols3 == null || cols3.Length == 0)
            {
                return true;
            }

            var tableName = _getTableName();

            if (tableName == "training_material_text")
            {
                IBaseRepository<MaterialText> repo = new BaseRepository<MaterialText>(_dapperContext!, "training_material_text", "text_id");
                return await repo.UpdateAsync((material as MaterialText)!, (material as MaterialText)!.text_id, cols3);
            }
            else if (tableName == "training_material_videos")
            {
                IBaseRepository<MaterialVideo> repo = new BaseRepository<MaterialVideo>(_dapperContext!, "training_material_videos", "video_id");
                return await repo.UpdateAsync((material as MaterialVideo)!, (material as MaterialVideo)!.video_id, cols3);
            }
            else if (tableName == "training_material_files")
            {
                IBaseRepository<MaterialFile> repo = new BaseRepository<MaterialFile>(_dapperContext!, "training_material_files", "file_id");
                return await repo.UpdateAsync((material as MaterialFile)!, (material as MaterialFile)!.file_id, cols3);
            }
            else if (tableName == "training_material_mcqs")
            {
                IBaseRepository<MaterialMCQ> repo = new BaseRepository<MaterialMCQ>(_dapperContext!, "training_material_mcqs", "question_id");
                return await repo.UpdateAsync((material as MaterialMCQ)!, (material as MaterialMCQ)!.question_id, cols3);
            }
            else
            {
                throw new Exception("Invalid Material Type");
            }
        }

        public async Task<bool> DeleteSoftMaterialAsync(T material)
        {
            IBaseRepository<Material> materialRepository = new BaseRepository<Material>(_dapperContext!, "training_material", "material_id");
            return await materialRepository.DeleteSoftAsync((material as Material)!.material_id);
        }

        public async Task<bool> DeleteMaterialAsync(T material)
        {
            IBaseRepository<Material> materialRepository = new BaseRepository<Material>(_dapperContext!, "training_material", "material_id");
            return await materialRepository.DeleteAsync((material as Material)!.material_id);

            // TODO: delete from specific material table
        }
    }
}