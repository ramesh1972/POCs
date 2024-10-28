
namespace DestinyLimoServer.DTOs.RequestDTOs
{   
    public class NewExamDTO 
    {
        public int UserId { get; set; }
        public DateTime DateCreated { get; set; }
        public DateTime DateStarted { get; set; }
        public DateTime DateCompleted { get; set; }
    }
}