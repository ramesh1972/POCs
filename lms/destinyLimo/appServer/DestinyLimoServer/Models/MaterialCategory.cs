using DestinyLimoServer.Common.DB;

namespace DestinyLimoServer.Models
{
    public class MaterialCategory
    {

        [Column(Name = "material_category_id")]
        public required int material_category_id { get; set; }

        [Column(Name = "category_name")]
        public required string category_name { get; set; }

        [Column(Name = "category_description")]
        public required string category_description { get; set; }

        [Column(Name = "is_active")]
        public bool is_active { get; set; }

        [Column(Name = "is_deleted")]
        public bool is_deleted { get; set; }
    }
}
