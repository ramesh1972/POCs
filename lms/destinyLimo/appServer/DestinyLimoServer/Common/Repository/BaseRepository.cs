using Dapper;
using DestinyLimoServer.Common.DB;
using DestinyLimoServer.Models;
using Microsoft.VisualBasic;
using MySql.Data.MySqlClient;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace DestinyLimoServer.Common.Repository
{
    public class BaseRepository<T>(DapperContext context, string tableName, string idColumn) : IBaseRepository<T> where T : class
    {
        protected DapperContext _context = context;
        protected string? _tableName = tableName;
        protected string? _idColumn = idColumn;

        protected MySqlConnection CreateConnection()
        {
            return _context.CreateConnection();
        }

        public async Task<IEnumerable<T>> GetAllAsync()
        {
            //string cols = GetColumnsASModelProperties();

            using var connection = CreateConnection();
            var sql = $"SELECT * FROM {_tableName}";
            return await connection.QueryAsync<T>(sql);
        }

        public async Task<IEnumerable<T>> GetAllAsync(bool inactive, bool is_deleted = false)
        {
            using var connection = CreateConnection();

            if (inactive == true)
            {
                var sql = $"SELECT * FROM {_tableName} WHERE is_deleted = @is_deleted";
                return await connection.QueryAsync<T>(sql, new { is_deleted = is_deleted });
            }
            else
            {
                var sql = $"SELECT * FROM {_tableName} WHERE is_active = @is_active AND is_deleted = @is_deleted";
                return await connection.QueryAsync<T>(sql, new { is_active = true, is_deleted = is_deleted });
            }
        }

        public async Task<T> GetByIdAsync(int id)
        {
            using var connection = CreateConnection();
            var sql = $"SELECT * FROM {_tableName} WHERE {_idColumn} = @Id";
            var result = await connection.QuerySingleOrDefaultAsync<T>(sql, new { Id = id });
            return result ?? default!;
        }

        public async Task<IEnumerable<T>> GetMultipleByIdAsync(int id)
        {
            using var connection = CreateConnection();
            var sql = $"SELECT * FROM {_tableName} WHERE {_idColumn} = @Id";
            var result = await connection.QueryAsync<T>(sql, new { Id = id });
            return result ?? default!;
        }

        public async Task<int> AddAsync(T? entity, string[]? cols = null)
        {
            using var connection = CreateConnection();
            var sql = $"INSERT INTO {_tableName} ({GetInsertColumns(cols)}) VALUES ({GetInsertParameters(cols)})";
            var success  = await connection.ExecuteAsync(sql, entity);
            if (success == 1)
            {
                var id = await connection.QuerySingleAsync<int>("SELECT LAST_INSERT_ID()");
                return id;
            }
            
            return -1;
        }

        public async Task<IEnumerable<int>> AddMultipleAsync(IEnumerable<T> entities)
        {
            using var connection = CreateConnection();
            var sql = $"INSERT INTO {_tableName} ({GetInsertColumns()}) VALUES ({GetInsertParameters()})";
            await connection.ExecuteAsync(sql, entities);

            // return the last inserted bunch of ids
            // Assume an auto-increment ID column named 'id'
            sql = $"SELECT {_idColumn} FROM {_tableName} WHERE {_idColumn} >= LAST_INSERT_ID() AND {_idColumn} < LAST_INSERT_ID() + ROW_COUNT()";
            return await connection.QueryAsync<int>(sql);
        }

        public async Task<bool> UpdateAsync(T entity, int id, string[]? cols = null)
        {
            using var connection = CreateConnection();
            var sql = $"UPDATE {_tableName} SET {GetUpdateColumns(cols)} WHERE {_idColumn} = @{_idColumn}";

            int recs = await connection.ExecuteAsync(sql, entity);
            if (recs == 1)
                return true;

            return false;
        }
            

        public async Task<bool> DeleteAsync(int id)
        {
            using var connection = CreateConnection();
            var sql = $"DELETE FROM {_tableName} WHERE {_idColumn} = @Id";

            int recs = await connection.ExecuteAsync(sql, new { Id = id });

            if (recs == 1)
                return true;

            return false;
        }

        // assumes there is a column named "is_deleted" in the table
        public async Task<bool> DeleteSoftAsync(int id)
        {
            using var connection = CreateConnection();
            var sql = $"UPDATE {_tableName} SET is_deleted = 1 WHERE {_idColumn} = @Id";

            int recs = await connection.ExecuteAsync(sql, new { Id = id });

            if (recs == 1)
                return true;

            return false;
        }

        public async Task<IEnumerable<T>> QueryAsync(string sql, object? parameters = null)
        {
            using var connection = CreateConnection();
            return await connection.QueryAsync<T>(sql, parameters);
        }

        public async Task<T> QuerySingleAsync(string sql, object? parameters = null)
        {
            using var connection = CreateConnection();
            var result = await connection.QuerySingleOrDefaultAsync<T>(sql, parameters);
            return result ?? default!;
        }

        public async Task<T> QueryFirstOrDefaultAsync(string sql, object? parameters = null)
        {
            using var connection = CreateConnection();
            var result = await connection.QueryFirstOrDefaultAsync<T>(sql, parameters);
            return result ?? default!;
        }
        public async Task<int> ExecuteAsync(string sql, object? parameters = null)
        {
            using var connection = CreateConnection();
            return await connection.ExecuteAsync(sql, parameters);
        }

        public async Task<IEnumerable<dynamic>> QueryDynamicAsync(string sql, object? parameters = null)
        {
            using var connection = CreateConnection();
            return await connection.QueryAsync(sql, parameters);
        }

        private static Object ConvertToDataType(Type type, string value)
        {
            if (type == typeof(int))
            {
                return Convert.ToInt32(value);
            }
            else if (type == typeof(string))
            {
                return value;
            }
            else if (type == typeof(DateTime))
            {
                return Convert.ToDateTime(value);
            }
            else if (type == typeof(bool))
            {
                return Convert.ToBoolean(value);
            }
            else if (type == typeof(double))
            {
                return Convert.ToDouble(value);
            }
            else if (type == typeof(decimal))
            {
                return Convert.ToDecimal(value);
            }
            else if (type == typeof(float))
            {
                return Convert.ToSingle(value);
            }
            else if (type == typeof(byte))
            {
                return Convert.ToByte(value);
            }
            else if (type == typeof(char))
            {
                return value[0];
            }
            else if (type == typeof(long))
            {
                return Convert.ToInt64(value);
            }
            else if (type == typeof(short))
            {
                return Convert.ToInt16(value);
            }
            else if (type == typeof(uint))
            {
                return Convert.ToUInt32(value);
            }
            else if (type == typeof(ulong))
            {
                return Convert.ToUInt64(value);
            }
            else if (type == typeof(ushort))
            {
                return Convert.ToUInt16(value);
            }
            else if (type == typeof(sbyte))
            {
                return Convert.ToSByte(value);
            }
            else if (type == typeof(Guid))
            {
                return new Guid(value);
            }
            else if (type == typeof(TimeSpan))
            {
                return TimeSpan.Parse(value);
            }
            else if (type == typeof(DateTimeOffset))
            {
                return DateTimeOffset.Parse(value);
            }
            else if (type == typeof(byte[]))
            {
                return Encoding.ASCII.GetBytes(value);
            }
            else if (type == typeof(Nullable<>))
            {
                return value;
            }
            else
            {
                return value;
            }
        }

        public T1 AssignValuesToModel<T1>(int id, List<EntityActionRecord> records)
        {
            var properties = typeof(T1).GetProperties();
            T1 model = (T1)System.Activator.CreateInstance(typeof(T1))!;

            // Loop through cols and values and assign values to model
            // Example: cols = ["id", "name"], values = ["1", "John"]
            var propId = properties.FirstOrDefault(p => p.Name.ToLower() == _idColumn?.ToLower());

            // get the record value and convert it to the appropriate type
            propId?.SetValue(model, ConvertToDataType(propId.PropertyType, id.ToString()));

            // fill the rest of the properties
            records.ForEach(rec =>
            {
                var prop = properties.FirstOrDefault(p => p.Name.ToLower() == rec.ColumnName?.ToLower());

                prop?.SetValue(model, BaseRepository<T>.ConvertToDataType(prop.PropertyType, rec.ColumnValue!));
            });

            return model;
        }

        protected string GetInsertColumns(string[]? cols = null)
        {
            if (cols == null)
            {
                return string.Join(", ", typeof(T).GetProperties().Where(p => (p.PropertyType.IsValueType || p.PropertyType == typeof(string)) && p.Name != _idColumn && p.Name != "created_at" && p.Name != "updated_at").Select(p => p.Name));
            }
            else
            {
                cols = cols.Where(c => c != _idColumn).ToArray();
                return string.Join(", ", cols);
            }
        }

        private string GetDataType(string colName)
        {
            return typeof(T).GetProperty(colName)?.PropertyType.Name ?? "string";
        }

        protected string GetInsertParameters(string[]? cols = null)
        {
            if (cols == null)
            {
                return string.Join(", ", typeof(T).GetProperties().Where(p => (p.PropertyType.IsValueType || p.PropertyType == typeof(string)) && p.Name != _idColumn && p.Name != "created_at" && p.Name != "updated_at").Select(p => "@" + p.Name));
            }
            else
            {
                cols = cols.Where(c => c != _idColumn).ToArray();
                return string.Join(", ", cols.Select(c => "@" + c));
            }
        }

        protected string GetUpdateColumns(string[]? cols = null)
        {
            if (cols == null)
            {
                return string.Join(", ", typeof(T).GetProperties().Where(p => (p.PropertyType.IsValueType || p.PropertyType == typeof(string)) && p.Name != _idColumn && p.Name != "created_at").Select(p => p.Name + " = @" + p.Name));
            }
            else
            {
                return string.Join(", ", cols.Select(c => c + " = @" + c));
            }
        }
    }
}