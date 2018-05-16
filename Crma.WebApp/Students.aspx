<%@ Page Title="Students" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Students.aspx.cs" Inherits="Students" %>

<asp:Content ID="Content2" ContentPlaceHolderID="Header" runat="server">
    <link href="Content/assets/css/select2.min.css" rel="stylesheet" />
    <link href="/Scripts/select2/select2-optional.css" rel="stylesheet" />
    <script src="/Scripts/app/Common.js?v=1.30"></script>
    <script src="/Scripts/app/DataService.min.js?v=1.30"></script>
    <script src="/Scripts/app/DefaultGridVariables.min.js?v=1.30"></script>
    <script src="/content/assets/js/jquery.validate.js"></script>
    <script src="/content/assets/js/additional-methods.min.js"></script>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="page-content">
        <div class="page-header">
            <h1>Students</h1>
        </div>
        <div class="row">
            <div class="col-xs-12 widget-container-col">
                <div class="clearfix">
                    <a id="addNewItem" role="button" href="#addModal" data-toggle="modal" class="btn btn-white btn-warning btn-bold"
                        tabindex="0" title="Add new"><i class="fa fa-plus bigger-110"></i>Add new</a>
                    <div class="pull-right tableTools-container"></div>
                </div>
                <div class="widget-box widget-color-blue" id="widget-box-2">
                    <div class="widget-header">
                        <h5 class="widget-title bigger lighter">Students List</h5>
                        <div class="widget-toolbar">
                            <a href="#" data-action="fullscreen" class="white">
                                <i class="1 ace-icon fa fa-expand bigger-125"></i>
                            </a>
                        </div>
                    </div>
                    <div class="widget-body">
                        <div class="widget-main no-padding">
                            <table id="listItems" class="table table-striped table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th>Photo</th>
                                        <th>Name</th>
                                        <th>Gender</th>
                                        <th>Class room name</th>
                                        <th>DOB</th>
                                        <th>Balance</th>
                                        <th>Options</th>
                                    </tr>
                                </thead>
                                <tbody></tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="addModal" class="modal fade" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header no-padding">
                    <div class="table-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                            <span class="white">&times;</span>
                        </button>
                        Add/Edit Student
                    </div>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-xs-12 col-sm-12">
                            <form class="form-horizontal" role="form" id="aspnetForm">
                                <div>
                                    <input type="hidden" id="id" value="0" />
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label no-padding-right" for="gender">Gender <span class="text-danger">*</span></label>
                                    <div class="col-sm-9">
                                        <select class="form-control col-sm-10 select2 required" id="gender" name="gender" style="width: 280px"
                                            data-fn-name="Genders_Names" data-placeholder="Select gender" data-allow-clear="true">
                                            <option value=""></option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label no-padding-right" for="student_image">Photo <span class="text-danger">*</span></label>
                                    <div class="col-sm-9">
                                        <input type="text" class="col-sm-10 required" required id="student_image" name="student_image" placeholder="student_image" />

                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label no-padding-right" for="name">Name</label>
                                    <div class="col-sm-9">
                                        <input type="text" class="col-sm-10" id="name" name="name" placeholder="Name" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label no-padding-right" for="dob">Date of birth</label>
                                    <div class="col-sm-9">
                                        <input type="text" class="col-sm-10 date-picker" id="dob" name="dob" placeholder="Date of birth" data-date-format="mm/dd/yyyy" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label no-padding-right" for="balance">Balance</label>
                                    <div class="col-sm-9">
                                        <input type="number" class="col-sm-10" id="balance" name="balance" value="0" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label no-padding-right" for="classroom_id">Class room</label>
                                    <div class="col-sm-9">
                                        <select class="form-control col-sm-10 select2 required" id="classroom_id" name="classroom_id" style="width: 280px"
                                            data-fn-name="Classrooms_Names" data-placeholder="Select class room" data-allow-clear="true">
                                            <option value=""></option>
                                        </select>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="modal-footer no-margin-top">
                    <button class="btn btn-sm btn-primary" id="btnSave">
                        <i class="ace-icon fa fa-check"></i>
                        Save
                    </button>
                    <button class="btn btn-sm btn-danger" data-dismiss="modal">
                        <i class="ace-icon fa fa-times"></i>
                        Close
                    </button>
                </div>
            </div>
        </div>
    </div>
    <!-- /.add-modal-dialog -->
    <div id="deleteModal" class="modal fade" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header no-padding">
                    <div class="table-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                            <span class="white">&times;</span>
                        </button>
                        Delete item
                    </div>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-xs-12 col-sm-12">
                            <form action="#" class="form-horizontal" id="removeForm">
                                <label id="Label2">Are you sure to delete the selected item (<label class="removeField"></label>)?</label>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="modal-footer no-margin-top">
                    <button class="btn btn-sm btn-primary btn-delete" id="btnDelete">
                        <i class="ace-icon fa fa-check"></i>
                        Delete
                    </button>
                    <button class="btn btn-sm btn-danger" data-dismiss="modal">
                        <i class="ace-icon fa fa-times"></i>
                        Cancel
                    </button>
                </div>
            </div>
        </div>
    </div>
    <!-- /.delete-modal-dialog -->
    <script src="/Scripts/select2/select2.min.js"></script>
    <script src="/Scripts/lz-string/lz-string.min.js"></script>
    <script src="/Scripts/xml2json.js"></script>
    <script src="/Scripts/select2/select2-optinal.js?v=1.3"></script>
    <script src="/Scripts/app/DefaultGridManager.min.js?v=1.30"></script>
    <script src="/Scripts/app/Students-manager.js?v=1.30"></script>
</asp:Content>
