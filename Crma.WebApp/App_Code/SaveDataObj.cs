namespace Crma.WebApp
{
    // models
    public class SaveDataObj
    {
        public string actionName { get; set; }
        public string[] names { get; set; }
        public string[] values { get; set; }
    }

    public class SaveMasterDetailsDataModel
    {
        public string actionName { get; set; }
        public string[] namesM { get; set; }
        public string[] valuesM { get; set; }
        public string[] namesD { get; set; }
        public string[] valuesD { get; set; }
        public bool useIP { get; set; } = false;
    }

    public class DataListModel
    {
        public string actionName { get; set; }
        public string[] names { get; set; }
        public string[] values { get; set; }
    }
}