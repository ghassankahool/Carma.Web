using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(Crma.WebApp.Startup))]
namespace Crma.WebApp
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
