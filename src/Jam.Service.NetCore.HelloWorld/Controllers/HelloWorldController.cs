using Microsoft.AspNetCore.Mvc;
using System;

namespace Jam.Service.NetCore.HelloWorld.Controllers
{
    [Route("jam/api/helloworld/")]
    public class HelloWorldController : Controller
    {
        [HttpGet()]
        public IActionResult HelloWorld()
        {
            var currentTime = DateTime.Now.ToString("HH:mm"); 

            return new OkObjectResult($"Hello, World!\nThe time is {currentTime}!");
        }
    }
}