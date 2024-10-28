using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace PEExperimentsWeb.Pages;

public class UseCaseIndexModel : PageModel
{
    private readonly ILogger<UseCaseIndexModel> _logger;

    public UseCaseIndexModel(ILogger<UseCaseIndexModel> logger)
    {
        _logger = logger;
    }

    public void OnGet()
    {

    }
}
