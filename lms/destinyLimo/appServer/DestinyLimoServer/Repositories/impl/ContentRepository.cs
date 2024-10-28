using DestinyLimoServer.Common.DB;
using DestinyLimoServer.Common.Repository;
using DestinyLimoServer.Models;

namespace DestinyLimoServer.Repositories.impl
{
    public class ContentRepository : BaseRepository<Content>, IContentRepository
    {
        public ContentRepository(DapperContext dapperContext) : base(dapperContext, "content", "content_id")
        {
            //Dapper.SqlMapper.SetTypeMap(typeof(Content), new ColumnAttributeTypeMapper<Content>());
        }

        public async Task<IEnumerable<Content>> GetAllContents(bool inactive = true, bool is_deleted = false)
        {
            return await GetAllAsync(inactive, is_deleted);
        }

        public async Task<Content> GetContentById(int ContentId)
        {
            return await GetByIdAsync(ContentId);
        }

        public async Task<Content> GetContentByContentTypeId(int contentTypeId)
        {
            return await GetByIdAsync(contentTypeId);
        }
    }
}