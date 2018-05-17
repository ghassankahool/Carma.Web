<%@ Page Title="Students" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Students.aspx.cs" Inherits="Students" %>

<asp:Content ID="Content2" ContentPlaceHolderID="Header" runat="server">
    <link href="Content/assets/css/select2.min.css" rel="stylesheet" />
    <link href="/Scripts/select2/select2-optional.css" rel="stylesheet" />
    <link rel="stylesheet" href="/content/assets/css/bootstrap-editable.css" />
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
                                        <th width="35px">Photo</th>
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
                                        <span class="profile-picture">
                                            <img class="student_image editable img-responsive" data-placement="right" alt="News photo" src="/public/default.jpg" />
                                            <input type="hidden" id="student_image" value="" name="student_image" />
                                        </span>

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
    <!--Student profile-->
    <div id="profileModal" class="modal fade" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header no-padding">
                    <div class="table-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                            <span class="white">&times;</span>
                        </button>
                        Student Profile
                    </div>
                </div>
                <div class="modal-body">
                    <div class="row" id="st_profile_content">
                        <div class="col-xs-12 col-sm-12">
                            <h1 class="hidden">Student Profile</h1>
                            <img id="student_image_preview" src="public/default.jpg" style="max-width: 400px;" />
                            <table class="table table-condensed" id="student_profile">
                                <tr>
                                    <td><strong>Name</strong></td>
                                    <td><span class="name"></span></td>
                                </tr>
                                <tr>
                                    <td><strong>Gender</strong></td>
                                    <td><span class="gender_name"></span></td>
                                </tr>
                                <tr>
                                    <td><strong>Class room</strong></td>
                                    <td><span class="classroom_name"></span></td>
                                </tr>
                                <tr>
                                    <td><strong>Date of birth</strong></td>
                                    <td><span id="stu_dob"></span></td>
                                </tr>
                                <tr>
                                    <td><strong>Balance</strong></td>
                                    <td><span class="balance"></span></td>
                                </tr>
                            </table>
                        </div>
                        <div id="st_profile"></div>
                    </div>
                </div>
                <div class="modal-footer no-margin-top">
                    <button class="btn btn-sm btn-success" id="btnDownloadPDF">
                        <i class="ace-icon fa fa-file-pdf-o"></i>
                        Download PDF
                    </button>
                    <button class="btn btn-sm btn-danger" data-dismiss="modal">
                        <i class="ace-icon fa fa-times"></i>
                        Cancel
                    </button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageScripts" runat="Server">
    <script src="/content/assets/js/bootstrap-editable.min.js"></script>
    <script src="/content/assets/js/ace-editable.min.js"></script>
    <script src="/Scripts/select2/select2.min.js"></script>
    <script src="/Scripts/lz-string/lz-string.min.js"></script>
    <script src="/Scripts/xml2json.js"></script>
    <script src="/Scripts/select2/select2-optinal.js?v=1.3"></script>
    <script src="/Scripts/app/DefaultGridManager.js?v=1.30"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/0.9.0rc1/jspdf.min.js"></script>
    <script src="/Scripts/app/Students-manager.js?v=1.30"></script>
</asp:Content>
