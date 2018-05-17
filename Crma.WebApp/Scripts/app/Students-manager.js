modalDialog = "addModal"; formName = 'aspnetForm'; deleteModalDialog = 'deleteModal';
tableName = "Students";
pKey = "id";
gridId = "listItems";
gridColumns = [];
gridColumns.push(
    {
        "mData": function (row) {
            if (row.student_image)
                return '<a class="image" href="/public/images/' + row.student_image + '" title="Download"><img src="/public/images/_thumb/' + row.student_image + '" style="width:30px;"/></a>';
            else
                return '<img src="/public/default.jpg" style="width:30px;"/>';
        },
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
            return '<a href="javascript:void(0);" class="btn btn-white btn-sm btn-danger pdf" title="Download PDF"><i class="fa fa-file-pdf-o"></i></a> ' +
                '<button class="btn btn-primary btn-white btn-sm edit" title="Edit"><i class="fa fa-pencil"></i></button> ' +
                '<button class="btn btn-danger btn-white btn-sm remove" title="Delete"><i class="fa fa-trash"></i></button>'
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

    if (rowData.student_image) {
        $('img.student_image').attr('src', '/public/images/_thumb/' + rowData.student_image);
    } else {
        $('img.student_image').attr('src', '/public/default.jpg');
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
// Grid events
$("#" + gridId + " tbody").delegate("tr a", "click", function (event) {
    event.preventDefault();
    var self = $(this), pos = self.closest('tr');


    if (pos !== null) {
        if (self.hasClass('pdf')) {
            var
                oTable = $('#' + gridId).DataTable(),
                aData = oTable.row(pos).data(); // get data of the clicked row

            // show student profile
            $.each(aData, function (k, v) {
                console.log(k, v);
                $('#profileModal .' + k).text(v);
            });

            var _domain = 'http://' + window.location.host;

            if (aData.student_image) {
                $('#student_image_preview').attr('src', _domain + '/public/images/_thumb/' + aData.student_image);
            } else {
                $('#student_image_preview').attr('src', _domain + '/public/default.jpg');
            }

            if (aData.dob) {
                $('#stu_dob').text(moment(aData.dob).format('MM/DD/YYYY'));
            }

            $('#profileModal').modal('show');

        } else if (self.hasClass('image')) {
            var imagePathToDownload = self.attr('href'),
                a = $("<a>").attr("href", imagePathToDownload).attr("download", imagePathToDownload).appendTo("body");
            a[0].click();
            a.remove();
        }
    }
});

// download pdf

var doc = new jsPDF('p', 'pt', 'a4', true);
doc.setFontSize(14);

var specialElementHandlers = {
    '#st_profile': function (element, renderer) {
        return true;
    }
};


$('#btnDownloadPDF').click(function (e) {
    e.preventDefault();

    // All units are in the set measurement for the document
    // This can be changed to "pt" (points), "mm" (Default), "cm", "in"
    doc.fromHTML($('#st_profile_content').get(0), 15, 15, {
        'width': 1000,
        'elementHandlers': specialElementHandlers
    });

    // add profile image
    var image_el = $('#student_image_preview'),
        image_url = image_el.attr('src'),
        image_width = image_el.width() || 180,
        image_height = image_el.height() || 150;

    var img = new Image(), canvas = document.createElement("canvas");
    canvas.width = image_width;
    canvas.height = image_height;
    var ctx = canvas.getContext("2d");

    img.onload = function () {
        ctx.drawImage(img, 0, 0);
        var imgData = canvas.toDataURL('image/jpeg');

        var width = img.width,
            height = img.height;
        doc.addImage(imgData, 'JPEG', 400, 40, width, height);

        // save pdf file
        doc.save('student-profile.pdf');
        $('.modal').modal('hide');
    }
    img.src = image_url;
});


jQuery(function ($) {

    var
        uploadImage = function () {
            // upload to the server.
            var upload_url = '/api/Upload',
                imgStr = $('#student_image').data('img');

            if (imgStr === '') {
                commonManger.showMessage('Upload faild!', 'Please try again by uploading image or contact system administrator.');
                return false;
            }

            var
                media = {
                    ID: imgStr
                },
                uploaded =
                    function (dd) {
                        if (dd.indexOf('Error') <= 0) {
                            $('#student_image').val(dd)
                            return true;
                        }
                        else
                            return false;
                    };

            console.log(media);

            dataService.callAjax('POST', JSON.stringify(media), upload_url,
                uploaded, commonManger.errorException);
        },
        bindFullImage = function ($image) {
            var reader = new FileReader(),
                $imgg = $('.student_image:eq(0)');

            reader.onloadend = function () {
                if ($imgg) {
                    $imgg.data('base64', reader.result.split(',')[1]);
                }
            }
            reader.readAsDataURL($image);
        };

    //editables on first profile page
    $.fn.editable.defaults.mode = 'inline';
    $.fn.editableform.loading = "<div class='editableform-loading'><i class='ace-icon fa fa-spinner fa-spin fa-2x light-blue'></i></div>";
    $.fn.editableform.buttons = '<button type="submit" class="btn btn-info editable-submit"><i class="ace-icon fa fa-check"></i></button>' +
        '<button type="button" class="btn editable-cancel"><i class="ace-icon fa fa-times"></i></button>';

    //editables on first profile page
    try {//ie8 throws some harmless exceptions, so let's catch'em

        //first let's add a fake appendChild method for Image element for browsers that have a problem with this
        //because editable plugin calls appendChild, and it causes errors on IE at unpredicted points
        try {
            document.createElement('IMG').appendChild(document.createElement('B'));
        } catch (e) {
            Image.prototype.appendChild = function (el) { }
        }

        var last_gritter,
            $photo = $('.student_image');

        $photo.editable({
            //mode: 'inline',
            type: 'image',
            name: 'student_image',
            value: null,
            //onblur: 'ignore',  //don't reset or hide editable onblur?!
            image: {
                //specify ace file input plugin's options here
                btn_choose: 'Change photo',
                droppable: true,
                //minSize: 110000,//~100Kb

                //and a few extra ones here
                name: 'student_image',//put the field name here as well, will be used inside the custom plugin
                on_error: function (error_type) {//on_error function will be called when the selected file has a problem
                    if (last_gritter) $.gritter.remove(last_gritter);
                    if (error_type == 1) {//file format error
                        last_gritter = $.gritter.add({
                            title: 'File is not an image!',
                            text: 'Please choose a jpg|gif|png image!',
                            class_name: 'gritter-error gritter-center'
                        });
                    } else if (error_type == 2) {//file size rror
                        last_gritter = $.gritter.add({
                            title: 'File too big!',
                            text: 'Image size should not exceed 100Kb!',
                            class_name: 'gritter-error gritter-center'
                        });
                    }
                    else {//other error
                    }
                },
                on_success: function () {
                    $.gritter.removeAll();
                }
            },
            url: function (params) {
                // ***UPDATE AVATAR HERE*** //
                var deferred = new $.Deferred

                var value = $photo.next().find('input[type=hidden]:eq(0)').val();
                if (!value || value.length == 0) {
                    deferred.resolve();
                    return deferred.promise();
                }

                //dummy upload
                setTimeout(function () {
                    if ("FileReader" in window) {
                        //for browsers that have a thumbnail of selected image
                        var thumb = $photo.next().find('img').data('thumb'),
                            full = $photo.next().find('img').data('full');

                        if (thumb) $photo.get(0).src = thumb;
                        if (full) {
                            $('#student_image').data('img', full.split(',')[1]);
                            uploadImage();
                        }
                    }

                    deferred.resolve({ 'status': 'OK' });

                    if (last_gritter) $.gritter.remove(last_gritter);

                }, parseInt(Math.random() * 800 + 800))

                return deferred.promise();
                // ***END OF UPDATE AVATAR HERE*** //
            },
            success: function (response, newValue) { }
        })
    } catch (e) { }
});
