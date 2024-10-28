using DestinyLimoServer.Common.Repository;

namespace DestinyLimoServer.Repositories
{
    public interface IRepositoryManager
    {
        IRoleRepository Role { get; }
        IUserRepository User { get; }
        IUserProfileRepository UserProfile { get; }
        IContentRepository Content { get; }
        IMaterialCategoryRepository MaterialCategory { get; }
        IMaterialRepository<T> Material<T>() where T : class;
        IExamRepository Exam { get; }
        IUserQuestionRepository UserQuestion { get; }
    }
}