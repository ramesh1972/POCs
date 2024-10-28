using System.Net;
using Microsoft.AspNetCore.Mvc;

namespace DestinyLimoServer.Common.ApiResponse
{
    public class ApiResponse
    {
        public bool Success { get; set; }
        public string Message { get; set; }
        public object? Data { get; set; }

        public ApiResponse(bool success, string message, object? data)
        {
            Success = success;
            Message = message;
            Data = data;
        }

        public ApiResponse(bool success, string message)
        {
            Success = success;
            Message = message;
        }

        public static IActionResult SuccessResponse(string message, object data)
        {
            return new OkObjectResult(new ApiResponse(true, message, data));
        }

        public static IActionResult SuccessResponse(string message)
        {
            return new OkObjectResult(new ApiResponse(true, message));
        }

        public static IActionResult ErrorResponse(HttpStatusCode statusCode, string message)
        {
            return new ObjectResult(new ApiResponse(false, message))
            {
                StatusCode = (int)statusCode
            };
        }

        public static IActionResult ErrorResponse(HttpStatusCode statusCode, string message, object data)
        {
            return new ObjectResult(new ApiResponse(false, message, data))
            {
                StatusCode = (int)statusCode
            };
        }

        public static IActionResult ErrorResponse()
        {
            return new ObjectResult(new ApiResponse(false, "An error occurred"))
            {
                StatusCode = (int)HttpStatusCode.InternalServerError
            };
        }

        public static IActionResult ExceptionResponse(Exception ex)
        {
            String msg = ex.Message;
            return new ObjectResult(new ApiResponse(false, msg))
            {
                StatusCode = (int)HttpStatusCode.ExpectationFailed
            };
        }
    }
}