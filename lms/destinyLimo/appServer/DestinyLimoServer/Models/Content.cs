using DestinyLimoServer.Common.DB;

namespace DestinyLimoServer.Models
{
    public class Content
    {
        [Column(Name = "content_id")]
        public int content_id { get; set; }

        [Column(Name = "content_type_id")]
        public required int content_type_id { get; set; }
    
        [Column(Name = "title")]
        public required string title { get; set; }

        [Column(Name = "description")]
        public required string description { get; set; }

        [Column(Name = "is_public")]
        public Boolean is_public { get; set; }

        [Column(Name = "is_active")]
        public Boolean is_active { get; set; }

        [Column(Name = "is_deleted")]
        public Boolean is_deleted { get; set; }
    }
}
