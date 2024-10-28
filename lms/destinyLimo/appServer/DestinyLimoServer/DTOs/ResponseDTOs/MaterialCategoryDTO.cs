using DestinyLimoServer.Common.DB;
using Mysqlx.Crud;
using System.ComponentModel.DataAnnotations;

namespace DestinyLimoServer.DTOs.ResponseDTOs
{
    public class MaterialCategoryDTO
    {
        public int Id{ get; set; }
        public required string category_name { get; set; }
        public required string category_description { get; set; }

        public bool is_active { get; set; }

        public bool is_deleted { get; set; }
    }
}
