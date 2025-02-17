<!DOCTYPE html>
<html>
    <head>
        <title>User Profile</title>
        <style>
            body {
                font-family: sans-serif;
                background-color: #f4f4f4;
            }
            nav {
                background-color: #333;
                color: white;
                padding: 10px;
            }

            nav a {
                color: white;
                text-decoration: none;
                margin-right: 20px;
            }

            .container {
                display: flex;
                width: 60%;
                margin: 30px auto;
                background-color: white;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            .sidebar {
                width: 200px;
                padding: 20px;
                text-align: center;
                border-right: 1px solid #ddd;
            }

            .sidebar img {
                width: 200px;
                height: 200px;
                border-radius: 50%;
                margin-bottom: 10px;
                object-fit: cover;
            }

            .content {
                flex: 1;
                padding: 20px;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 20px;
            }

            th, td {
                padding: 10px;
                text-align: left;
                border-bottom: 1px solid #ddd;
            }

            th {
                font-weight: bold;
                width: 30%;
            }

            .btn {
                background-color: #007bff;
                text-decoration: none;
                color: white;
                border: none;
                padding: 10px 20px;
                border-radius: 5px;
                cursor: pointer;
            }

            .btn:hover {
                background-color: #0056b3;
            }
        </style>
    </head>
    <body>
        <nav>
            <a href="Home.jsp">Home</a>
        </nav>
        <div class="container">
            <div class="sidebar">
                <img src="img/DefaultAvt.png" id="display" alt="Avatar" accept=".png">
            </div>
            <div class="content">
                <table>
                    <tr>
                        <th>ID</th>
                        <td>${sessionScope.acc.id}</td>
                    </tr>
                    <tr>
                        <th>Name</th>
                        <td>${sessionScope.acc.uname}</td>
                    </tr>
                    <tr>
                        <th>Phone number</th>
                        <td>${sessionScope.acc.uphone}</td>
                    </tr>
                    <tr>
                        <th>Email</th>
                        <td>${sessionScope.acc.umail}</td>
                    </tr>
                    <tr>
                        <th>Role</th>
                        <td>${sessionScope.acc.isStaff == 1 ? "Staff" : (sessionScope.acc.isAdmin == 1 ? "Admin" : "User")}</td>

                    </tr>
                </table>
                <a href="editprofile?id=${sessionScope.acc.id}" class="btn">Edit</a>
            </div>
        </div>
    </body>

</html>