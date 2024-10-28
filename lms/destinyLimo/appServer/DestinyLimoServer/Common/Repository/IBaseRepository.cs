using System.Collections.Generic;
using System.Threading.Tasks;

namespace DestinyLimoServer.Common.Repository
{
    public interface IBaseRepository<T> where T : class
    {
        Task<IEnumerable<T>> GetAllAsync();
        Task<IEnumerable<T>> GetAllAsync(bool inactive, bool is_deleted = false);
        Task<T> GetByIdAsync(int id);
        Task<int> AddAsync(T? entity, string[]? cols = null);

        Task<IEnumerable<int>> AddMultipleAsync(IEnumerable<T> entities);
        Task<bool> UpdateAsync(T entity, int id, string[]? cols = null);
        Task<bool> DeleteAsync(int id);
        Task<bool> DeleteSoftAsync(int id);

        // Additional methods
        Task<IEnumerable<T>> QueryAsync(string sql, object? parameters = null);
        Task<T> QuerySingleAsync(string sql, object? parameters = null);
        Task<T> QueryFirstOrDefaultAsync(string sql, object? parameters = null);
        Task<int> ExecuteAsync(string sql, object? parameters = null);
        Task<IEnumerable<dynamic>> QueryDynamicAsync(string sql, object? parameters = null);
    }
}