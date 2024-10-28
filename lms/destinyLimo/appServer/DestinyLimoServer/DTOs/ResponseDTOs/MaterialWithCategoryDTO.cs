namespace DestinyLimoServer.DTOs.ResponseDTOs
{
    public class MaterialWithCategoryDTO
    {
        public IEnumerable<MaterialDTO>? materials { get; set; }
        public IEnumerable<MaterialCategoryDTO>? categories { get; set; }
    }
}