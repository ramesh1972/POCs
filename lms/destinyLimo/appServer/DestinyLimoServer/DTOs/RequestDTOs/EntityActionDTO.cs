namespace DestinyLimoServer.DTOs.RequestDTOs
{
    public class EntityActionDTO
    {
        public int IdCol { get; set; }

        public string? IdColName { get; set; }

        public string? ParentTableName { get; set; }

        public required string Action { get; set; }

        public List<EntityActionRecordDTO>? Records { get; set; }
    }
}