using DestinyLimoServer.Models;

namespace DestinyLimoServer.Repositories
{
    public interface IContentRepository
    {
        Task<Content> GetContentById(int ContentId);
        Task<Content> GetContentByContentTypeId(int contentTypeId);
        Task<IEnumerable<Content>> GetAllContents(bool inactive = true, bool is_deleted = false);

        Task<int> AddAsync(Content entity, string[]? cols = null);
        Task<bool> UpdateAsync(Content entity, int id, string[]? cols = null);
        Task<bool> DeleteAsync(int id);
        Task<bool> DeleteSoftAsync(int id);
    }
}