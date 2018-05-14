<%@ Page Title="Employees" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Employees.aspx.cs" Inherits="Employees" %>

<asp:Content ID="Content2" ContentPlaceHolderID="Header" runat="server">
    <script src="/Scripts/app/Common.min.js?v=1.30"></script>
    <script src="/Scripts/app/DataService.min.js?v=1.30"></script>
    <script src="/Scripts/app/DefaultGridVariables.min.js?v=1.30"></script>
    <script src="/content/assets/js/jquery.validate.js"></script>
    <script src="/content/assets/js/additional-methods.min.js"></script>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="page-content">
        <div class="page-header">
            <h1>Employees</h1>
        </div>
        <div class="row">
            <div class="col-xs-12 widget-container-col">
                <div class="clearfix">
                    <a role="button" href="#addModal" data-toggle="modal" class="btn btn-white btn-warning btn-bold"
                        tabindex="0" title="Add new"><i class="fa fa-plus bigger-110"></i>Add new</a>
                    <div class="pull-right tableTools-container"></div>
                </div>
                <div class="widget-box widget-color-blue" id="widget-box-2">
                    <div class="widget-header">
                        <h5 class="widget-title bigger lighter">Employees List</h5>
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
                                        <th>Email</th>
                                        <th>Phone</th>
                                        <th>Department</th>
                                        <th>PoBox</th>
                                        <th>Salary</th>
                                        <th>Active</th>
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
                        Add/Edit Account
                    </div>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-xs-12 col-sm-12">
                            <form class="form-horizontal" role="form" id="aspnetForm">
                                <div>
                                    <input type="hidden" id="UserID" value="0" />
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label no-padding-right" for="UserFullName">Type <span class="text-danger">*</span></label>
                                    <div class="col-sm-9">
                                        <select class="col-sm-10 required" required id="TypeID" name="TypeID">
                                            <option value="1">Employee</option>
                                            <option value="2">Transporter</option>
                                            <option value="3">Crane/Driver</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label no-padding-right" for="UserFullName">Name <span class="text-danger">*</span></label>
                                    <div class="col-sm-9">
                                        <input type="text" class="col-sm-10 required" required id="UserFullName" name="UserFullName" placeholder="Username" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label no-padding-right" for="Username">Username</label>
                                    <div class="col-sm-9">
                                        <input type="text" class="col-sm-10" id="Username" placeholder="Username" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label no-padding-right" for="Password">Password</label>
                                    <div class="col-sm-9">
                                        <input type="text" class="col-sm-10 password" id="Password" placeholder="Password" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label no-padding-right" for="Phone">Phone</label>
                                    <div class="col-sm-9">
                                        <input type="text" class="col-sm-10" id="Phone" placeholder="00971000000000" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label no-padding-right" for="Mobile">Mobile</label>
                                    <div class="col-sm-9">
                                        <input type="text" class="col-sm-10" id="Mobile" placeholder="00971000000000" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label no-padding-right" for="Email">Email</label>
                                    <div class="col-sm-9">
                                        <input type="text" class="col-sm-10" id="Email" placeholder="email@domain.com" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-3 control-label no-padding-right" for="Nationality">Nationality</label>
                                    <div class="col-sm-9">
                                        <input type="text" class="col-sm-10" id="Nationality" placeholder="Username" />
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
    <script src="/Scripts/app/DefaultGridManager.min.js?v=1.30"></script>
    <script src="/Scripts/app/users-manager.js?v=1.30"></script>
</asp:Content>
