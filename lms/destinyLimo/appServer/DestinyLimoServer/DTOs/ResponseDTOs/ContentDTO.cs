namespace DestinyLimoServer.DTOs.ResponseDTOs
{
    public class ContentDTO
    {
        public int Id { get; set; }

        public required int content_type_id { get; set; }

        public required string title { get; set; }

        public required string description { get; set; }

        public Boolean is_public { get; set; }

        public Boolean is_active { get; set; }

        public Boolean is_deleted { get; set; }
    }
}
