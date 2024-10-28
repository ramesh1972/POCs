using DestinyLimoServer.Models;
using System.Collections.Generic;
using DestinyLimoServer.Common.Repository;
namespace DestinyLimoServer.Repositories
{
    public interface IBulkUpdateRepository
    {
        bool BulkUpdateEntities(string tableName, List<EntityAction> entityActions);
    }
}