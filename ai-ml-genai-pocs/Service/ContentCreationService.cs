using ContentCreation.Models;

namespace ContentCreation.Service 
{
    public class ContentCreationService
    {
        public BlogContent Blog;

        public void GenerateContent(ContentItemType contentType, boolean generateSectionTitle);
                // connect to ChatGPT generate bsed on ContentType and create proper Model class

        public void RePhraseContent(int index);

        public void RemoveContent(int index);

        public GetBlogHTML()
        {
            return Blog.GetBlogHTML();
        }

        public SaveToDatabase() 
        {
            // TODO extra marks. connect to DB abd save
        }
    }
}