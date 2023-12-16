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
                var url = "http://127.0.0.1:7070/get-answer";

                var jsonPayload = JsonConvert.SerializeObject(questionRequest);
                
                var content = new StringContent(jsonPayload, Encoding.UTF8, "application/json");

                var response = await _httpClient.PostAsync(url, content);
                

                if (response.IsSuccessStatusCode)
                {
                    var jsonResponse = await response.Content.ReadAsStringAsync();
                    var answer = JsonConvert.DeserializeObject<AiAnswer>(jsonResponse);
                    
                    return answer;
                }
                else
                {
                    return null;
                }
            }
            catch (Exception ex)
            {
                // Handle exceptions
                throw;
            }
        }
    }

}
