//=======================================
// Developer: Mo. Salah (14-5-2018)
// Email: eng.msalah.abdullah@gmail.com
//=======================================

using System;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Script.Services;
using System.IO;
using System.Collections;
using Carma.Business.DataUtility;
using Carma.Business.Business;

public partial class api_data : System.Web.UI.Page
{
    #region "Get General Data"

    [WebMethod] // paged by scroll
    public static string GetPagedList(string pageIndex, string pageSize, string actionName)
    {
        // create filter paramters
        string[,] _params = { { "PageIndex", pageIndex }, { "PageSize", pageSize } };

        // get all of data.
        var _ds = new Select().SelectPagedLists(actionName, _params);
        string compressedXML = TrimmerUtil.RemoveSpaces(_ds.GetXml());
        return compressedXML;
    }

    [WebMethod]
    [ScriptMethod(UseHttpGet = true)]
    public static object LoadDataTables()
    {
        jQueryDataTableParamModel param = new jQueryDataTableParamModel();
        HttpContext Context = HttpContext.Current;
        param.sEcho = String.IsNullOrEmpty(Context.Request["sEcho"]) ? 0 : Convert.ToInt32(Context.Request["sEcho"]);
        param.sSearch = String.IsNullOrEmpty(Context.Request["sSearch"]) ? "" : Context.Request["sSearch"];
        param.iDisplayStart += String.IsNullOrEmpty(Context.Request["iDisplayStart"]) ? 0 : Convert.ToInt32(Context.Request["iDisplayStart"]);
        param.iDisplayLength = String.IsNullOrEmpty(Context.Request["iDisplayLength"]) ? 0 : Convert.ToInt32(Context.Request["iDisplayLength"]);
        var sortColumnIndex = Convert.ToInt32(Context.Request["iSortCol_0"]);
        var sortDirection = Context.Request["sSortDir_0"];// asc or desc          

        // create filter parameters
        string[,] _params = {{"DisplayStart",param.iDisplayStart.ToString()}, {"DisplayLength", param.iDisplayLength.ToString()},
                             {"SearchParam", param.sSearch}, {"SortColumn", sortColumnIndex.ToString()}, {"SortDirection", sortDirection}};

        // get all of data.
        var _ds = new Select().SelectLists(Context.Request["funName"], _params);

        // enhance data to be list.
        var rows = DataUtilities.ConvertDTToList(_ds.Tables[0]);

        var data = new
        {
            param.sEcho,
            iTotalRecords = _ds.Tables[1].Rows[0][0],
            iTotalDisplayRecords = _ds.Tables[1].Rows[0][0],
            aaData = rows.ToList()
        };

        return data;
    }

    [WebMethod]
    [ScriptMethod(UseHttpGet = false)]
    public static object GetData(string actionName, string value)
    {
        // create filter paramters
        string[,] _params = { { "Id", value } };

        // get all of data.
        var _ds = new Select().SelectLists(actionName, _params);
        string compressedXML = TrimmerUtil.RemoveSpaces(_ds.GetXml());
        return compressedXML;
    }

    [WebMethod]
    [ScriptMethod(UseHttpGet = false)]
    public static object GetDataDirect(string actionName)
    {
        // get all of data.
        var _ds = new Select().SelectLists(actionName);
        string compressedXML = TrimmerUtil.RemoveSpaces(_ds.GetXml());
        return compressedXML;
    }

    [WebMethod]
    [ScriptMethod(UseHttpGet = false)]
    public static string GetDataList(string actionName, string[] names, string[] values)
    {
        // get all of data.
        var _ds = new Select().SelectLists(actionName, names, values);
        string compressedXML = TrimmerUtil.RemoveSpaces(_ds.GetXml());
        return compressedXML;
    }

    [WebMethod]
    [ScriptMethod(UseHttpGet = false)]
    public static object saveData(string actionName, string[] names, string[] values)
    {   // start save data.
        var saved = new Save().SaveRow(actionName, names, values);
        object data = new { };

        if (saved != -1)
        {
            data = new
            {
                ID = saved,
                Status = true,
                message = Resources.Resource.SuccessSave
            };
        }
        else
        {
            data = new { ID = 0, status = false, message = Resources.Resource.ErrorSave };
        }

        return data;
    }

    [WebMethod]
    [ScriptMethod(UseHttpGet = true)]
    //[MinifyXml]
    public static object LoadDataTablesXML()
    {
        jQueryDataTableParamModel param = new jQueryDataTableParamModel();
        HttpContext Context = HttpContext.Current;

        param.sSearch = String.IsNullOrEmpty(Context.Request["sSearch"]) ? "" : Context.Request["sSearch"];
        param.iDisplayStart += String.IsNullOrEmpty(Context.Request["iDisplayStart"]) ? 0 : Convert.ToInt32(Context.Request["iDisplayStart"]);
        param.iDisplayLength = String.IsNullOrEmpty(Context.Request["iDisplayLength"]) ? 0 : Convert.ToInt32(Context.Request["iDisplayLength"]);
        var sortColumnIndex = Convert.ToInt32(Context.Request["iSortCol_0"]);
        var sortDirection = Context.Request["sSortDir_0"] ?? "desc"; // asc or desc

        // grid static parameters
        string[] names = { "DisplayStart", "DisplayLength", "SortColumn", "SortDirection", "SearchParam" },
                 values = { param.iDisplayStart.ToString(), param.iDisplayLength.ToString(), sortColumnIndex.ToString(), sortDirection, param.sSearch },

        // get dynamic more parameters from user
        addtionNames = string.IsNullOrEmpty(Context.Request["names"]) ? new string[0] : Context.Request["names"].Split('~'),
        addtionValues = string.IsNullOrEmpty(Context.Request["values"]) ? new string[0] : Context.Request["values"].Split('~'),


        // merge all parameters (union)
        namesAll = names.Concat(addtionNames).ToArray(),
        valuesAll = values.Concat(addtionValues).ToArray();


        // get all of data.
        var _ds = new Select().SelectLists(Context.Request["funName"], namesAll, valuesAll);

        // return data as xml
        return LZStringUpdated.compressToUTF16(_ds.GetXml());
    }
    #endregion
    
    #region "Car Images"
    [WebMethod] // car images
    public static ArrayList ShowCarImages(string id)
    {
        var context = HttpContext.Current;
        var dir = new DirectoryInfo(context.Server.MapPath(string.Format("~/public/cars/{0}/", id)));
        var imgs = new ArrayList();

        if (dir.Exists)
        {
            var files = dir.GetFiles();
            for (int i = 0; i < files.Count(); i++)
            {
                imgs.Add(files[i].Name);
            }
        }
        return imgs;
    }

    #endregion
        
    [WebMethod]
    public static String InlineEdit(string name, string value, string pk, string table, string id)
    {
        // enhance value
        value = value.Replace("'", " ");
        var isNumeric = !string.IsNullOrEmpty(value) && value.Replace(".", "").All(Char.IsDigit);
        if (!isNumeric)
        {
            value = string.Format("'{0}'", value);
        }

        // genrate update sql string
        string sqlStr = string.Format("Update {0} SET {1}={2} WHERE {3}={4}", table, name, value, id, pk);
        var d = new Save().RunSQLString(sqlStr);

        //access params here
        return "Data saved successfully.";
    }
    
    #region "instance search select2"

    [WebMethod]
    [ScriptMethod(UseHttpGet = true)]
    public static object getSelect2()
    {
        HttpContext Context = HttpContext.Current;
        string pageNum = Context.Request["pageNum"],
               pageSize = Context.Request["pageSize"],
               searchTerm = Context.Request["searchTerm"],
               fnName = Context.Request["fnName"],
               names = Context.Request["names"],
               values = Context.Request["values"];

        // grid static parameters
        string[] defaultNames = { "pageNum", "pageSize", "key" },
                 defaultValues = { pageNum, pageSize, searchTerm },

        // get dynamic more parameters from user
        addtionNames = string.IsNullOrEmpty(names) ? new string[0] : names.Split('~'),
        addtionValues = string.IsNullOrEmpty(values) ? new string[0] : values.Split('~'),

        // merge all parameters (union)
        namesAll = defaultNames.Concat(addtionNames).ToArray(),
        valuesAll = defaultValues.Concat(addtionValues).ToArray();

        var _ds = new Select().SelectLists(fnName, namesAll, valuesAll);
        return LZStringUpdated.compressToUTF16(_ds.GetXml());
    }

    #endregion
}