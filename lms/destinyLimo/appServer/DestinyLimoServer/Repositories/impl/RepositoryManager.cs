using DestinyLimoServer.Common.DB;

namespace DestinyLimoServer.Repositories.impl
{
    public class RepositoryManager(DapperContext dapperContext) : IRepositoryManager
    {
        private DapperContext _dapperContext = dapperContext;
        private IRoleRepository? _roleRepository;
        private IUserRepository? _userRepository;
        private IUserProfileRepository? _userProfileRepository;
        private IMaterialCategoryRepository? _materialCategoryRepository;
        private IContentRepository? _contentRepository;
        private IExamRepository? _examRepository;
        private IUserQuestionRepository? _userQuestionRepository;

        public IRoleRepository Role
        {
            get
            {
                _roleRepository ??= new RoleRepository(_dapperContext);
                return _roleRepository;
            }
        }

        public IUserRepository User
        {
            get
            {
                _userRepository ??= new UserRepository(_dapperContext);
                return _userRepository;
            }
        }

        public IUserProfileRepository UserProfile
        {
            get
            {
                _userProfileRepository ??= new UserProfileRepository(_dapperContext);
                return _userProfileRepository;
            }
        }
        
        public IContentRepository Content
        {
            get
            {
                _contentRepository ??= (IContentRepository)new ContentRepository(_dapperContext);
                return _contentRepository;
            }
        }

        public IMaterialCategoryRepository MaterialCategory
        {
            get
            {
                _materialCategoryRepository ??= (IMaterialCategoryRepository)new MaterialCategoryRepository(_dapperContext);
                return _materialCategoryRepository;
            }
        }

        public IMaterialRepository<T> Material<T>() where T : class
        {
            return new MaterialRepository<T>(_dapperContext);
        }
        
        public IExamRepository Exam
        {
            get
            {
                _examRepository ??= (IExamRepository)new ExamRepository(_dapperContext);
                return _examRepository;
            }
        }

        public IUserQuestionRepository UserQuestion
        {
            get
            {
                _userQuestionRepository ??= (IUserQuestionRepository)new UserQuestionRepository(_dapperContext);
                return _userQuestionRepository;
            }
        }
    }
}