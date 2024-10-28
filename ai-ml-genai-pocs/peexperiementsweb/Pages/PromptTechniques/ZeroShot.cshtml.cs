using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace PEExperimentsWeb.Pages;

public class ZeroShotIndexModel : PageModel
{
    private readonly ILogger<ZeroShotIndexModel> _logger;

    public ZeroShotIndexModel(ILogger<ZeroShotIndexModel> logger)
    {
        _logger = logger;
    }

    public void OnGet()
    {

    }
}
