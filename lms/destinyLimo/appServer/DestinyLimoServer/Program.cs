using DestinyLimoServer.Common.DB; // Add this using directive for DapperContext
using DestinyLimoServer.Common.Repository; // Add this using directive for IBaseRepository
using DestinyLimoServer.Common.Mapper; // Add this using directive for MappingProfile
using DestinyLimoServer.Models; // Add this using directive for Content
using DestinyLimoServer.Repositories; // Add this using directive for IRepositoryManager
using DestinyLimoServer.Repositories.impl; // Add this using directive for RepositoryManager
using AutoMapper; // Add this using directive for IMapper
using Microsoft.Extensions.FileProviders; // Add this using directive for PhysicalFileProvider

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

// read configuration
// get the environment variable
var env = Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT") ?? "Development";
Console.WriteLine($"Environment: {env}");

// read the configuration file
var configuration = new ConfigurationBuilder()
    .SetBasePath(Directory.GetCurrentDirectory())
    .AddJsonFile("appSettings.json", optional: false, reloadOnChange: true)
    .AddJsonFile($"appSettings.{env}.json", optional: true)
    .AddEnvironmentVariables()
    .Build();

// register the configuration
builder.Services.AddSingleton<IConfiguration>(configuration);

// Add CORS policy
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll",
        builder =>
        {
            builder.AllowAnyOrigin()
                   .AllowAnyMethod()
                   .AllowAnyHeader();
        });
});

// setup DI for DapperContext
builder.Services.AddSingleton<DapperContext>(provider =>
{
    var connectionString = configuration.GetConnectionString("MySqlConnection") ?? throw new Exception("Connection string is null.");
    return new DapperContext(connectionString);
});

var connectionString = configuration.GetConnectionString("MySqlConnection") ?? throw new Exception("Connection string is null.");
Console.WriteLine($"Connection string: {connectionString}");

// Auto Mapper Configurations
var mapperConfig = new MapperConfiguration(mc =>
{
    mc.AddProfile(new MappingProfile());
});

builder.Services.AddAutoMapper(typeof(MappingProfile));

IMapper mapper = mapperConfig.CreateMapper();
builder.Services.AddSingleton(mapper);

// logger
builder.Services.AddTransient(provider =>
{
    var loggerFactory = provider.GetRequiredService<ILoggerFactory>();
    const string categoryName = "Any";
    return loggerFactory.CreateLogger(categoryName);
});

// add controllers
builder.Services.AddControllers();

// add common services
builder.Services.AddScoped<IRepositoryManager, RepositoryManager>();
builder.Services.AddScoped<IContentRepository, ContentRepository>();
builder.Services.AddScoped<IUserRepository, UserRepository>();
builder.Services.AddScoped<IRoleRepository, RoleRepository>();
builder.Services.AddScoped<IMaterialCategoryRepository, MaterialCategoryRepository>();
builder.Services.AddScoped<IBulkUpdateRepository, BulkUpdateRepository>();
builder.Services.AddScoped<IMaterialRepository<MaterialFile>, MaterialRepository<MaterialFile>>();
builder.Services.AddScoped<IMaterialRepository<MaterialText>, MaterialRepository<MaterialText>>();
builder.Services.AddScoped<IMaterialRepository<MaterialVideo>, MaterialRepository<MaterialVideo>>();
builder.Services.AddScoped<IMaterialRepository<MaterialMCQ>, MaterialRepository<MaterialMCQ>>();
builder.Services.AddScoped<IExamRepository, ExamRepository>();
builder.Services.AddScoped<IUserQuestionRepository, UserQuestionRepository>();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}


// Custom middleware to handle CORS for static files
app.Use(async (context, next) =>
{
    context.Response.Headers.Append("Access-Control-Allow-Origin", "*");
    context.Response.Headers.Append("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS");
    context.Response.Headers.Append("Access-Control-Allow-Headers", "Content-Type, Authorization");
    await next.Invoke();
});

// Serve static files from the "UploadedFiles" folder
var uploadPath = configuration.GetSection("Uploads").GetValue<string>("Destination") ?? throw new Exception("Upload path is null.");
var fileserverPath = configuration.GetSection("Uploads").GetValue<string>("FileServePath") ?? throw new Exception("File serve path is null.");

Console.WriteLine($"Upload path: {uploadPath}");
Console.WriteLine($"File server path: {fileserverPath}");

app.UseStaticFiles(new StaticFileOptions
{
    FileProvider = new PhysicalFileProvider(uploadPath),
    RequestPath = fileserverPath
});

app.UseRouting();

//app.UseHttpsRedirection();
app.MapControllers();

// Enable CORS
app.UseCors("AllowAll");

app.Run();