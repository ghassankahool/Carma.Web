var targetdata; modalDialog = "addModal"; formName = 'aspnetForm'; deleteModalDialog = 'deleteModal';
tableName = "Students";
pKey = "id";
gridId = "listItems";
gridColumns = [];
gridColumns.push(
    {
        "mDataProp": "student_image",
        "bSortable": false
    }, {
        "mDataProp": "name",
        "bSortable": true
    }, {
        "mDataProp": "gender_name",
        "bSortable": true
    }, {
        "mDataProp": "classroom_name",
        "bSortable": true
    }, {
        "mData": function (row) {
            return row.dob ? moment(row.dob).format('MM/DD/YYYY') : '';
        },
        "bSortable": true
    }, {
        "mDataProp": "balance",
        "bSortable": true
    }, {
        "mDataProp": null,
        "bSortable": false,
        "mData": function () {
            return '<button class="btn btn-primary btn-mini edit" title="Edit"><i class="fa fa-pencil"></i></button> ' +
                '<button class="btn btn-danger btn-mini remove" title="Delete"><i class="fa fa-trash"></i></button>'
        }
    });

DefaultGridManager.Init();


// events
$.fn.afterLoadDatawithdata = function (rowData) {
    if (rowData.classroom_id) {
        $('#classroom_id').select2("trigger", "select", {
            data: { id: rowData.classroom_id, text: rowData.classroom_name }
        });
    }
    if (rowData.gender) {
        $('#gender').select2("trigger", "select", {
            data: { id: rowData.gender, text: rowData.gender_name }
        });
    }
}

// modal load
$('#addNewItem').click(function (e) {
    e.preventDefault();
    commonManger.ResetControls(formName);
    
    $(".select2").val("").trigger("change");
    $(".select2").trigger("change");
});

//validation
$('#aspnetForm').validate({
    errorElement: 'div',
    errorClass: 'help-block',
    focusInvalid: false,
    ignore: "",
    highlight: function (e) {
        $(e).closest('.form-group').removeClass('has-info').addClass('has-error');
    },
    success: function (e) {
        $(e).closest('.form-group').removeClass('has-error');//.addClass('has-info');
        $(e).remove();
    },
    errorPlacement: function (error, element) {
        if (element.is('input[type=checkbox]') || element.is('input[type=radio]')) {
            var controls = element.closest('div[class*="col-"]');
            if (controls.find(':checkbox,:radio').length > 1) controls.append(error);
            else error.insertAfter(element.nextAll('.lbl:eq(0)').eq(0));
        }
        else if (element.is('.select2')) {
            error.insertAfter(element.siblings('[class*="select2-container"]:eq(0)'));
        }
        else if (element.is('.chosen-select')) {
            error.insertAfter(element.siblings('[class*="chosen-container"]:eq(0)'));
        }
        else error.insertAfter(element.parent());
    },

    submitHandler: function (form) {
    },
    invalidHandler: function (form) {
    }
});
$('#btnSave').click(function (e) {
    e.preventDefault();
    $('#aspnetForm').submit();
});