using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(IndianWebsite.Startup))]
namespace IndianWebsite
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
