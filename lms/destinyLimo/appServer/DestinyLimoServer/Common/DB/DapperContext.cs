using MySql.Data.MySqlClient;
using System.Data;

namespace DestinyLimoServer.Common.DB
{
    public class DapperContext
    {
        private readonly string? _connectionString;

        public DapperContext(string connectionString)
        {
            System.Console.WriteLine("DapperContext constructor: " + connectionString);
            _connectionString = connectionString;

            Dapper.DefaultTypeMap.MatchNamesWithUnderscores = true;
        }
        public MySqlConnection CreateConnection()
        {
            System.Console.WriteLine("DapperContext CreateConnection: " + _connectionString);
            MySqlConnection mysql = new MySqlConnection(_connectionString);
            mysql.Open();
            Console.WriteLine("DapperContext CreateConnection: " + mysql.State);
            return mysql;
        }
    }
}