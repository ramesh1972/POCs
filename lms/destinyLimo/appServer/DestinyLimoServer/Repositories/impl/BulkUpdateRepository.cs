using DestinyLimoServer.Common.DB;
using DestinyLimoServer.Common.Repository;
using DestinyLimoServer.Repositories;
using DestinyLimoServer.Models;

using System;
using System.Data.Common;

namespace DestinyLimoServer.Repositories.impl
{
    public class BulkUpdateRepository(DapperContext dapperContext) : BaseRepository<List<EntityAction>>(dapperContext, "NA", "NA"), IBulkUpdateRepository
    {
        private DapperContext? _dapperContext = dapperContext;
        private IRepositoryManager _repositoryManager = new RepositoryManager(dapperContext);

        private bool _bulkUpdateEntities<T1>(string tableName, BaseRepository<T1>? _repository, List<EntityAction> entityActions) where T1 : class
        {
            if (entityActions.Count == 0)
            {
                return false;
            }

            tableName = tableName.ToLower();
            this._tableName = tableName;
            this._idColumn = entityActions[0].IdColName;

            bool isMaterial = tableName == "training_material_files" ? true : false;

            try
            {
                entityActions.ForEach(async x =>
                {
                    var modelObject = AssignValuesToModel<T1>(x.Id, [.. x.EntityActionRecords!]);

                    string[] modifiedCols = x.EntityActionRecords!.Select(y => y.ColumnName!).ToArray();

                    if (modifiedCols.Length > 0)
                    {

                        if (isMaterial)
                        {
                            IMaterialRepository<T1> repo = _repositoryManager.Material<T1>();

                            if (x.Action == "insert")
                                await repo!.AddMaterialAsync((T1)(object)modelObject);
                            else if (x.Action == "update")
                                await repo!.UpdateMaterialAsync((T1)(object)modelObject, modifiedCols);
                            else if (x.Action == "delete")
                                if (modifiedCols.Contains("is_deleted"))
                                    await repo!.DeleteSoftMaterialAsync((T1)(object)modelObject);
                                else
                                    await repo!.DeleteMaterialAsync((T1)(object)modelObject);
                        }
                        else
                        {
                            if (x.Action == "insert")
                                await _repository!.AddAsync((T1)(object)modelObject, modifiedCols);
                            else if (x.Action == "update")
                                await _repository!.UpdateAsync((T1)(object)modelObject, x.Id, modifiedCols);
                            else if (x.Action == "delete")
                                if (modifiedCols.Contains("is_deleted"))
                                    await _repository!.DeleteSoftAsync(x.Id);
                                else
                                    await _repository!.DeleteAsync(x.Id);
                        }
                    }
                });
            }
            catch (Exception)
            {
                return false;
            }

            return true;
        }

        private bool _bulkUpdateMaterialEntities<T1>(string tableName, List<EntityAction> entityActions) where T1 : class
        {
            if (entityActions.Count == 0)
            {
                return false;
            }

            tableName = tableName.ToLower();
            this._tableName = tableName;
            this._idColumn = entityActions[0].IdColName;

            try
            {
                entityActions.ForEach(async x =>
                {
                    var modelObject = AssignValuesToModel<T1>(x.Id, [.. x.EntityActionRecords!]);

                    string[] modifiedCols = x.EntityActionRecords!.Select(y => y.ColumnName!).ToArray();

                    if (modifiedCols.Length > 0)
                    {
                        IMaterialRepository<T1> repo = _repositoryManager.Material<T1>();

                        if (x.Action == "insert")
                            await repo!.AddMaterialAsync((T1)(object)modelObject, modifiedCols);
                        else if (x.Action == "update")
                            await repo!.UpdateMaterialAsync((T1)(object)modelObject, modifiedCols);
                        else if (x.Action == "delete")
                            if (modifiedCols.Contains("is_deleted"))
                                await repo!.DeleteSoftMaterialAsync((T1)(object)modelObject);
                            else
                                await repo!.DeleteMaterialAsync((T1)(object)modelObject);
                    }
                });
            }
            catch (Exception)
            {
                return false;
            }

            return true;
        }

        public bool BulkUpdateEntities(string tableName, List<EntityAction> entityActions)
        {
            if (entityActions.Count == 0)
            {
                return false;
            }

            tableName = tableName.ToLower();
            this._tableName = tableName;
            this._idColumn = entityActions[0].IdColName;

            bool isSuccess = false;

            // training material tables
            if (tableName == "training_material_files")
                isSuccess = _bulkUpdateMaterialEntities<MaterialFile>(tableName, entityActions);
            else if (tableName == "training_material_text")
                isSuccess = _bulkUpdateMaterialEntities<MaterialText>(tableName, entityActions);
            else if (tableName == "training_material_videos")
                isSuccess = _bulkUpdateMaterialEntities<MaterialVideo>(tableName, entityActions);
            else if (tableName == "training_material_mcqs")
                isSuccess = _bulkUpdateMaterialEntities<MaterialMCQ>(tableName, entityActions);

            // material category                       
            else if (tableName == "training_material_category")
                isSuccess = _bulkUpdateEntities<MaterialCategory>("training_material_category",
                                        _repositoryManager.MaterialCategory as BaseRepository<DestinyLimoServer.Models.MaterialCategory>, entityActions);

            // content
            else if (tableName == "content")
                isSuccess = _bulkUpdateEntities<Content>("content",
                                        _repositoryManager.Content as BaseRepository<DestinyLimoServer.Models.Content>, entityActions);

            // users & roles
            else if (tableName == "role")
                isSuccess = _bulkUpdateEntities<Role>("role",
                                        _repositoryManager.Role as BaseRepository<DestinyLimoServer.Models.Role>, entityActions);
            else if (tableName == "user")
                isSuccess = _bulkUpdateEntities<User>("user",
                                        _repositoryManager.User as BaseRepository<DestinyLimoServer.Models.User>, entityActions);

            // user asked questions
            else if (tableName == "user_asked_questions")
                isSuccess = _bulkUpdateEntities<UserAskedQuestion>("user_asked_questions",
                                        _repositoryManager.UserQuestion as BaseRepository<DestinyLimoServer.Models.UserAskedQuestion>, entityActions);
            else
                isSuccess = false;

            return isSuccess;
        }
    }
}