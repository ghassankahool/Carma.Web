<%@ Application Language="C#" %>
<%@ Import Namespace="Carma.Web" %>
<%@ Import Namespace="System.Web.Optimization" %>
<%@ Import Namespace="System.Web.Routing" %>
<%@ Import Namespace="System.Web.Http" %>

<script runat="server">

    void Application_Start(object sender, EventArgs e)
    {
        RouteConfig.RegisterRoutes(RouteTable.Routes);
        BundleConfig.RegisterBundles(BundleTable.Bundles);
        GlobalConfiguration.Configure(WebApiConfig.Register);
    }

</script>
