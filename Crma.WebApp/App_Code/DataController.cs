//=======================================
// Developer: Mo. Salah (14-5-2018)
// Email: eng.msalah.abdullah@gmail.com
//=======================================

using Carma.Business.DataUtility;
using Carma.Business.Business;
using System;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Http;
using System.Xml;
using Crma.WebApp;

public class DataController : ApiController
{
    [HttpGet]
    [Route("api/data.aspx/LoadDataTables")]
    public object GetLoadDataTables()
    {
        var param = new jQueryDataTableParamModel();
        var Context = HttpContext.Current;
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

    //[ActionName("GetData")]
    [Route("api/data.aspx/GetData")]
    public string GetDataByID(string actionName, string value)
    {
        // create filter parameters
        string[,] _params = { { "Id", value } };

        // get all of data.
        var _ds = new Select().SelectLists(actionName, _params);
        return LZStringUpdated.compressToUTF16(_ds.GetXml());
    }

    public string GetDataDirect(string actionName)
    {
        // get all of data.
        var _ds = new Select().SelectLists(actionName);
        return LZStringUpdated.compressToUTF16(_ds.GetXml());
    }

    [HttpPost]
    public string GetDataList(DataListModel param)
    {
        if (param == null)
            return "Error!! null paramters";

        // get all of data.
        var _ds = new Select().SelectLists(param.actionName, param.names, param.values);
        return LZStringUpdated.compressToUTF16(_ds.GetXml());
    }

    /// <summary>
    /// Save data
    /// </summary>
    /// <param name="value">string actionName, string[] names, string[] values</param>
    /// <returns></returns>
    //[ActionName("saveData")]
    [Route("api/data.aspx/saveData")]
    public object PostsaveData([FromBody]SaveDataObj value)
    {
        var saved = new Save().SaveRow(value.actionName, value.names, value.values);
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


    //[ActionName("InlineEdit")]
    [Route("api/data.aspx/InlineEdit")]
    public string InlineEdit(string name, string value, string pk, string table, string id)
    {
        // inhance value
        value = value.Replace("'", " ");
        var isNumeric = !string.IsNullOrEmpty(value) && value.Replace(".", "").All(Char.IsDigit);
        if (!isNumeric)
        {
            value = string.Format("'{0}'", value);
        }

        // generate update sql string
        string sqlStr = string.Format("Update {0} SET {1}={2} WHERE {3}={4}", table, name, value, id, pk);
        var d = new Save().RunSQLString(sqlStr);

        //access params here
        return "Data saved successfully.";
    }

    //[ActionName("Select2")]
    [Route("api/data.aspx/getSelect2")]
    public string GetSelect2()
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
}
