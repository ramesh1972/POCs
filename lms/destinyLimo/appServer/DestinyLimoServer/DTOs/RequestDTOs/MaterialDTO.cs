namespace DestinyLimoServer.DTOs.RequestDTOs
{
    public class MaterialDTO
    {
        public int id { get; set; }
        public int material_id { get; set; }
        public int material_type_id { get; set; }
        public int? material_category_id { get; set; }
        public string? title { get; set; }
        public string? description { get; set; }
        public byte? thumbnail { get; set; }
        public string? background_img   { get; set; }
        public bool is_public { get; set; } = false;
        public bool is_active { get; set; } = true;
        public bool is_deleted { get; set; } = false;
        public DateTime created_at { get; set; }
        public DateTime updated_at { get; set; }
    }
}