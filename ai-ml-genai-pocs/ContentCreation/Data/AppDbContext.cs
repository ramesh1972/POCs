using Microsoft.EntityFrameworkCore;
using ContentCreation.Models;

public class AppDbContext:DbContext{
    public AppDbContext(DbContextOptions<AppDbContext> options):base(options)
    {

    }
    public DbSet<Lahari_Content> Lahari_content { get; set; } 

}