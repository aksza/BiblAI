namespace BiblAI.Services
{
    using System;
    using System.Collections.Generic;
    using System.Net.Http;
    using System.Text;
    using System.Threading.Tasks;
    using BiblAI.Models;
    using Newtonsoft.Json; // Ensure you have the Newtonsoft.Json NuGet package installed

    public class FastApiService
    {
        private readonly HttpClient _httpClient;

        public FastApiService(HttpClient httpClient)
        {
            _httpClient = httpClient;
        }

        public async Task<AiAnswer> GetAnswer(AiQuestion questionRequest)
        {
            try
            {
                var url = "http://localhost:7070/get-answer";

                // Convert questionRequest to JSON
                var jsonPayload = JsonConvert.SerializeObject(questionRequest);

                // Convert JSON payload to StringContent
                var content = new StringContent(jsonPayload, Encoding.UTF8, "application/json");

                //Console.WriteLine($"{jsonPayload}");
                // Make a POST request to the FastAPI endpoint
                var response = await _httpClient.PostAsync(url, content);
                

                // Check if the request was successful (status code 200-299)
                if (response.IsSuccessStatusCode)
                {
                    // Read and deserialize the JSON response
                    var jsonResponse = await response.Content.ReadAsStringAsync();
                    var answer = JsonConvert.DeserializeObject<AiAnswer>(jsonResponse);
                    if (answer == null)
                    {
                        answer = new AiAnswer()
                        {
                            Answer = "fake",
                            Question = "fake",
                            Time = "00:00"
                        };
                    }
                    return answer;
                }
                else
                {
                    // Handle the case where the request was not successful
                    Console.WriteLine($"Error: {response.StatusCode} - {response.ReasonPhrase}");
                    return null;
                }
            }
            catch (Exception ex)
            {
                // Handle exceptions
                Console.WriteLine($"Exception: {ex.Message}");
                return null;
            }
        }
    }

}
