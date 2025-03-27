<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Manage Accounts</title>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round" />
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons" />
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" />
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <<link rel="stylesheet" href="css/manacc.css"/>
    </head>
    <body>
        <div class="container">
            <div class="table-wrapper">
                <div class="table-title">
                    <div class="row">
                        <div class="col-sm-6">
                            <h2>Manage <b>Accounts</b></h2>
                        </div>
                        <div class="col-sm-6">
                            <a href="#addEmployeeModal" class="btn btn-success" data-toggle="modal"><i class="material-icons">&#xE147;</i> <span>Add New Account</span></a>
                        </div>
                    </div>
                </div>

                <table class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>User</th>
                            <th>Email</th>
                            <th>Role</th>
                            <th>Phone</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${alist}" var="a">
                            <tr>
                                <td>${a.id}</td>
                                <td>${a.user}</td>
                                <td>${a.email}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${a.isSell == 1}">Seller</c:when>
                                        <c:when test="${a.isAdmin == 1}">Admin</c:when>
                                        <c:otherwise>User</c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${a.phone}</td>
                                <td>
                                    <a href="#editEmployeeModal" class="edit" data-toggle="modal"><i class="material-icons" data-toggle="tooltip" title="Edit">&#xE254;</i></a>
                                    <a href="#deleteEmployeeModal" class="delete" data-toggle="modal"><i class="material-icons" data-toggle="tooltip" title="Delete">&#xE872;</i></a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        <div id="editEmployeeModal" class="modal fade" tabindex="-1" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form id="editAccountForm" method="post" action="editA">
                        <div class="modal-header">
                            <h4 class="modal-title">Edit Account</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body">
                            <input type="hidden" name="id" id="editId">
                            <div class="form-group">
                                <label>Name</label>
                                <input type="text" name="user" id="editUser" class="form-control">
                            </div>
                            <div class="form-group">
                                <label>Email</label>
                                <input type="text" name="email" id="editEmail" class="form-control">
                            </div>
                            <div class="form-group">
                                <label for="editRole">Role</label>
                                <select name="role" id="editRole" class="form-control">
                                    <option value="user">User</option>
                                    <option value="seller">Seller</option>
                                    <option value="admin">Admin</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Phone</label>
                                <input type="text" name="phone" id="editPhone" class="form-control">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                            <input type="submit" class="btn btn-success" value="Save">
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script>
            $(document).ready(function () {
                $(".edit").on("click", function () {
                    let row = $(this).closest("tr");
                    $("#editId").val(row.find("td:eq(0)").text().trim());
                    $("#editUser").val(row.find("td:eq(1)").text().trim());
                    $("#editEmail").val(row.find("td:eq(2)").text().trim());
                    $("#editPhone").val(row.find("td:eq(4)").text().trim());
                    let role = row.find("td:eq(3)").text().trim().toLowerCase();
                    $("#editRole").val(role);
                });
            });
        </script>

        <div id="addEmployeeModal" class="modal fade" tabindex="-1" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form id="addAccountForm">
                        <div class="modal-header">
                            <h4 class="modal-title">Add Account</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body">

                            <div id="errorMessage" class="alert alert-danger" style="display: none;"></div>

                            <div class="form-group">
                                <label>Name</label>
                                <input type="text" name="name" id="name" class="form-control" />
                            </div>

                            <div class="form-group">
                                <label>Email</label>
                                <input type="text" name="email" id="email" class="form-control" />
                            </div>

                            <div class="form-group">
                                <label for="role">Role</label>
                                <select name="role" id="role" class="form-control">
                                    <option value="">-- Select Role --</option>
                                    <option value="admin">Admin</option>
                                    <option value="seller">Seller</option>
                                    <option value="user">User</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label>Phone</label>
                                <input type="text" name="phone" id="phone" class="form-control" />
                            </div>
                        </div>
                        <div class="modal-footer">
                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel" />
                            <input type="submit" class="btn btn-success" value="Add" />
                        </div>
                    </form>
                </div>
            </div>
        </div>


        <script type="text/javascript">
            $(document).ready(function () {
                $("#addAccountForm").on("submit", function (e) {
                    e.preventDefault();


                    const name = $("#name").val().trim();
                    const email = $("#email").val().trim();
                    const role = $("#role").val();
                    const phone = $("#phone").val().trim();


                    let errorMessage = "";
                    if (!name) {
                        errorMessage = "Ten khong duoc de trong";
                    } else if (name.length > 30) {
                        errorMessage = "Ten nguoi dung khong duoc vuot qua 30 ky tu";
                    } else if (!/^[a-zA-Z0-9 ]+$/.test(name)) {
                        errorMessage = "Ten nguoi dung khong duoc chua ky tu dac biet";
                    } else if (!email) {
                        errorMessage = "Email khong duoc de trong";
                    } else if (!/^[a-zA-Z0-9._%+-]+@gmail\.com$/.test(email)) {
                        errorMessage = "Email phai dung dinh dang @gmail.com";
                    } else if (!phone) {
                        errorMessage = "So dien thoai khong duoc de trong";
                    } else if (!/^\d{10}$/.test(phone)) {
                        errorMessage = "So dien thoai phai du 10 ky tu va khong chua ky tu dac biet hay chu cai";
                    }

                    if (errorMessage) {
                        $("#errorMessage").text(errorMessage).show();
                        return;
                    }

                    $.ajax({
                        url: "addA",
                        type: "POST",
                        data: {name, email, role, phone},
                        success: function (response) {
                            alert(response);
                            location.reload();
                        },
                        error: function (xhr) {
                            const errorMessage = xhr.responseText;
                            $("#errorMessage").text(errorMessage).show();
                        }
                    });
                });
            });
        </script>
    </body>
</html>