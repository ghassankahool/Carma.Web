using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(Carma.Web.Startup))]
namespace Carma.Web
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
