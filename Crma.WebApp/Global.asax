<%@ Application Language="C#" %>
<%@ Import Namespace="Crma.WebApp" %>
<%@ Import Namespace="System.Web.Optimization" %>
<%@ Import Namespace="System.Web.Routing" %>

<script runat="server">

    void Application_Start(object sender, EventArgs e)
    {
        RouteConfig.RegisterRoutes(RouteTable.Routes);
        BundleConfig.RegisterBundles(BundleTable.Bundles);
        //GlobalConfiguration.Configure(WebApiConfig.Register); <%@ Import Namespace="System.Web.Http" %>
    }

</script>
