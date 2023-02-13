using Flurl.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Travelo.WinUI
{
    public class APIService
    {
        private string _resource = null;
        public string _endpoint = "https://localhost:7100/";

        public static string Email = null;
        public static string Password = null;


        public APIService(string resource) 
        {
            _resource= resource;
        }
        public async Task<T> Get<T>()
        {
            var list = await $"{_endpoint}{_resource}".WithBasicAuth(Email, Password).GetJsonAsync<T>();
            return list;
        }
        public async Task<T> GetById<T>(object id)
        {
            var result = await $"{_endpoint}{_resource}/{id}".WithBasicAuth(Email, Password).GetJsonAsync<T>();
            return result;
        }
        public async Task<T> Post<T>(object request)
        {
            try 
            {
                var result = await $"{_endpoint}{_resource}".WithBasicAuth(Email, Password).PostJsonAsync(request).ReceiveJson<T>();
                return result;
            }
            catch(FlurlHttpException ex)
            {
                var errors = await ex.GetResponseJsonAsync<Dictionary<string, string[]>>();

                var stringBuilder = new StringBuilder();
                foreach (var error in errors)
                {
                    stringBuilder.AppendLine($"{error.Key}, ${string.Join(",", error.Value)}");
                }

                MessageBox.Show(stringBuilder.ToString(), "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return default(T);
            }
            
            
        }
        public async Task<T> Put<T>(object id, object request)
        {
            var result = await $"{_endpoint}{_resource}/{id}".WithBasicAuth(Email, Password).PutJsonAsync(request).ReceiveJson<T>();
            return result;
        }
    }
}
