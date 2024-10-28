using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace PEExperimentsWeb.Pages
{

    public class FewShotIndexModel : PageModel
    {
        private readonly ILogger<FewShotIndexModel> _logger;

        public FewShotIndexModel(ILogger<FewShotIndexModel> logger)
        {
            _logger = logger;
        }

        public void OnGet()
        {

        }
    }
}