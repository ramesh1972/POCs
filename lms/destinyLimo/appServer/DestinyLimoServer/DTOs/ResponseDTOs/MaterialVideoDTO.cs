namespace DestinyLimoServer.DTOs.ResponseDTOs
{
    public class MaterialVideoDTO : MaterialDTO
    {
        public int video_id { get; set; }
        public string? url { get; set; }
        public Boolean is_vimeo { get; set; } = false;
    }
}