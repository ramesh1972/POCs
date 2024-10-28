namespace DestinyLimoServer.Models
{
    public class EntityAction
    {
        public int Id { get; set; }

        public string? IdColName { get; set; }

        public string? ParentTableName { get; set; }

        public required string Action { get; set; }

        public List<EntityActionRecord>? EntityActionRecords { get; set; }
    }
}