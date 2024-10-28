namespace DestinyLimoServer.Common.Uploader
{
    public static class UploadFilePaths
    {
        public const string ProfilePicture = "profile-pictures";
        public const string Content = "content";
        public const string TrainingMaterial = "training-material";
        public const string Other = "others";
    }

    public class FileUploader
    {
        // get the root uploads folder name from configuratio
        private string _rootUploadsFolderName = "";
        private string _fileServePath;
        private readonly ILogger _logger;

        private readonly IConfiguration _configuration = null!;

        // TODO configuratipn not getting DIed in production
        public FileUploader(ILogger logger, IConfiguration configuration)
        {
            _logger = logger;

            _configuration = configuration;

            _rootUploadsFolderName = _configuration.GetSection("Uploads").GetValue<string>("Destination")!;
            _fileServePath = _configuration.GetSection("Uploads").GetValue<string>("FileServePath")!;

            System.Console.WriteLine($"Root uploads folder name: {_rootUploadsFolderName}");
            System.Console.WriteLine($"File serve path: {_fileServePath}");

        }

        public string GetFilePathName(string folderName, string fileName)
        {
            // get relative path to web root
            string folderPath = folderName;
            string filePathName = folderPath + "/" + fileName;

            return filePathName;
        }

        public async Task<string> UploadFileAsync(IFormFile file, string folderName)
        {
            try
            {
                System.Console.WriteLine("Uploading file:" + file.FileName + " to folder:" + folderName);

                if (file == null || file.Length == 0)
                {
                    _logger.LogError("File is empty.");
                    return null!;
                }

                System.Console.WriteLine($"Root path: {_rootUploadsFolderName}");
                System.Console.WriteLine($"Folder name: {folderName}");
                
                string folderPath = Path.Combine(_rootUploadsFolderName, folderName);
                System.Console.WriteLine($"Folder path: {folderPath}");

                if (!Directory.Exists(folderPath))
                {
                    Directory.CreateDirectory(folderPath);
                }

                string filePath = Path.Combine(folderPath, file.FileName);
                System.Console.WriteLine($"File path & name: {filePath}");

                using (var fileStream = new FileStream(filePath, FileMode.Create))
                {
                    await file.CopyToAsync(fileStream);
                }

                System.Console.WriteLine("File uploaded successfully.");
                return filePath;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An error occurred while uploading the file.");
                return null!;
            }
        }

        public bool DeleteFile(string filePath)
        {
            try
            {
                if (File.Exists(filePath))
                {
                    File.Delete(filePath);
                    return true;
                }
                return false;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "An error occurred while deleting the file.");
                return false;
            }
        }
    }
}