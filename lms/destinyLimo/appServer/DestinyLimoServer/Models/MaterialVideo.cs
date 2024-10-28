namespace DestinyLimoServer.Models
{
    public class MaterialVideo : Material
    {
        public int video_id { get; set; }
        public string? url { get; set; }
        public Boolean is_vimeo { get; set; } = false;
    }
}