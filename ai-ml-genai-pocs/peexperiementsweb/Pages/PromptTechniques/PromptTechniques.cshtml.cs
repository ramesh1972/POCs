using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace PEExperimentsWeb.Pages;

public class PromptTechniquesIndexModel : PageModel
{
    private readonly ILogger<PromptTechniquesIndexModel> _logger;

    public PromptTechniquesIndexModel(ILogger<PromptTechniquesIndexModel> logger)
    {
        _logger = logger;
    }

    public void OnGet()
    {

    }
}
