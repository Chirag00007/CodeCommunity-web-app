<%@page import="com.code.entities.Post"%>
<%@page import="java.util.List"%>
<%@page import="com.code.entities.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.code.helper.ConnectionProvider"%>
<%@page import="code.code.dao.PostDao"%>
<%@page import="com.code.entities.Message"%>
<%@page import="com.code.entities.UserSignUp"%>
<%@page errorPage="error_pages.jsp" %>
<%
    UserSignUp user = (UserSignUp) session.getAttribute("currentUser");
    if (user == null) {
        response.sendRedirect("LoginPage.jsp");
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link href="CSS/MyStyle.css" rel="stylesheet" type="text/css"/>
        <style>
            .secondary_background{
                clip-path: polygon(30% 0%, 70% 0%, 94% 15%, 100% 70%, 100% 100%, 6% 91%, 0 50%, 4% 15%);

            }
            
        </style>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark primary_background">
            <a class="navbar-brand" href="index.jsp"><span class="fa fa-laptop"></span>Code Community</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Hire developers</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Contact Us</a>
                    </li>

                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Courses
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item" href="#">Full-Stack MERN developer</a>
                            <a class="dropdown-item" href="#">Full-Stack Java Developer</a>
                            <a class="dropdown-item" href="#">Machine Learning</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="#">Data Structures</a>
                            <a class="dropdown-item" href="#">Algorithms</a>
                        </div>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#" data-toggle="modal" data-target="#add-post-modal"><span class="fa fa-upload"></span> Do Post</a>
                    </li>
                </ul>
                <ul class="navbar-nav mr-right">
                    <li class="nav-item">

                        <a class="nav-link" href="#" data-toggle="modal" data-target="#profile-modal"><span class="fa fa-user-circle"></span> <%= user.getName()%> </a>
                    </li> 
                    <li class="nav-item">
                        <a class="nav-link" href="LogoutServlet"><span class="fa fa-sign-out"></span> Logout</a>
                    </li> 

                </ul>

            </div>
        </nav>

        <%
            Message m = (Message) session.getAttribute("msg");
            if (m != null) {
        %>
        <div class="alert <%= m.getCssClass()%>" role="alert">

            <%= m.getContent()%>
        </div>
        <%
                session.removeAttribute("msg");
            }
        %>

        <!--main-->
        <main>
            <div class="container " >
                <!--first-->
                <div class="row mt-4">
                    <div class="col-md-4">
                        <!--categories-->
                        <div class="list-group">
                            <a href="#" onclick="getPosts(0,this)" class="c-link list-group-item list-group-item-action active">
                                All Posts
                            </a>
                            <%
                                PostDao d = new PostDao(ConnectionProvider.getConnection());
                                ArrayList<Category> list1 = d.getAllCategories();

                                for (Category cc : list1) {
                            %>
                            <a href="#" onclick="getPosts(<%= cc.getCid()%>,this)" class="c-link list-group-item list-group-item-action disabled"><%=cc.getName()%> </a>
                            <%
                                }
                            %>


                        </div>

                    </div>

                    <!--second-->
                    <div class="col-md-8" >
                        <!--posts-->
                        <div class="container text-center" id="loader">

                            <i class="fa fa-refresh fa-3x fa-spin"></i>
                            <h3 class="mt-2">Loading....</h3>
                        </div>
                        <div class="container-fluid" id="post-container">

                        </div>

                    </div>

                </div>
            </div>
        </main>


        <!-- Modal -->
        <div class="modal fade" id="profile-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header primary_background text-white text-center">
                        <h5 class="modal-title" id="exampleModalLabel">Code Community</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="container text-center">
                            <img src="pics/<%= user.getProfile()%>" class="img-fluid" style="border-radius: 50%; max-width: 135px">
                            <br>
                            <h5 class="modal-title mt-3" id="exampleModalLabel"><%= user.getName()%></h5>

                            <div id="profile-detail">

                                <table class="table">

                                    <tbody>
                                        <tr>
                                            <th scope="row"> ID :</th>
                                            <td><%= user.getId()%></td>

                                        </tr>
                                        <tr>
                                            <th scope="row">Email :</th>
                                            <td><%= user.getEmail()%></td>

                                        </tr>
                                        <tr>
                                            <th scope="row">Gender :</th>
                                            <td><%= user.getGender()%></td>

                                        </tr>
                                        <tr>
                                            <th scope="row">Statues :</th>
                                            <td><%= user.getAbout()%></td>

                                        </tr>
                                        <tr>
                                            <th scope="row">Date Of Registration :</th>
                                            <td><%= user.getRdate().toString()%></td>

                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div id="profile-edit" style="display: none">
                                <h3>Please edit carefully</h3>
                                <form action="EditServlet" method="POST" enctype="multipart/form-data">

                                    <table class="table">

                                        <tr>
                                            <td>ID:</td>
                                            <td><%= user.getId()%></td>
                                        </tr>

                                        <tr>
                                            <td>Email :</td>
                                            <td><input type="email" class="form-control" name="user_email" value="<%= user.getEmail()%>"></td>
                                        </tr>
                                        <tr>
                                            <td>Name :</td>
                                            <td><input type="text" class="form-control" name="user_name" value="<%= user.getName()%>"></td>
                                        </tr>
                                        <tr>
                                            <td>Password :</td>
                                            <td><input type="password" class="form-control" name="user_password" value="<%= user.getPassword()%>"></td>
                                        </tr>
                                        <tr>
                                            <td>Gender :</td>
                                            <td><%= user.getGender().toUpperCase()%></td>
                                        </tr>
                                        <tr>
                                            <td>About :</td>
                                            <td>
                                                <textarea name="user_about" rows="3">
                                                    <%= user.getAbout()%>
                                                </textarea>
                                            </td>

                                        </tr>

                                        <tr>
                                            <td>Select image :</td>
                                            <td><input type="file" class="form-control" name="user_image"></td>
                                        </tr>

                                    </table>
                                    <div class="container">
                                        <button type="submit" class="btn btn-outline-light primary_background">Save</button></div>
                                </form>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            <button id="edit-profile-button" type="button" class="btn btn-primary">Edit</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Button trigger modal -->


        <!-- Modal -->
        <div class="modal fade" id="add-post-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel"> Provide the Post details </h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">

                        <form id="add-post-form" action="AddPostServlet" method="post">
                            <div class="form-group">
                                <select class="form-control" name="cid">
                                    <option >---Select category----</option>
                                    <%
                                        PostDao postd = new PostDao(ConnectionProvider.getConnection());
                                        ArrayList<Category> list = postd.getAllCategories();

                                        for (Category c : list) {
                                    %>

                                    <option value="<%= c.getCid()%>"> <%= c.getName()%></option>

                                    <%
                                        }
                                    %>

                                </select>
                            </div>

                            <div class="form-group">
                                <input type="text"  name="pTitle" required="required" placeholder="Enter post title" class="form-control"/>

                            </div>
                            <div class="form-group">
                                <textarea  name="pContent" style="height: 150px;" class="form-control" placeholder="Enter your Content"></textarea>
                            </div>
                            <div class="form-group">
                                <textarea  name="pCode" style="height: 150px;" class="form-control" placeholder="Enter your program(If any)"></textarea>
                            </div>
                            <div class="form-group">
                                <label>Upload content related Pics :</label><br>
                                <input name="pic" type="file"/>
                            </div>
                            <div class="container text-center">
                                <button type="submit" class="btn btn-outline-light primary_background">Post</button> 

                            </div>
                        </form>
                    </div>

                </div>
            </div>
        </div>   
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>                            
        <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script src="javascriptFiles/MyJS.js" type="text/javascript"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
        <script>
            $(document).ready(function () {

                let editStatus = false;
                $('#edit-profile-button').click(function () {
                    if (editStatus == false)
                    {
                        $("#profile-detail").hide()
                        $("#profile-edit").show();
                        editStatus = true;
                        $(this).text("Back")
                    } else {
                        $("#profile-detail").show()
                        $("#profile-edit").hide();
                        editStatus = false;
                        $(this).text("Edit")
                    }

                });
            });

        </script>

        <!--postJs-->

        <script>
            $(document).ready(function () {

                $("#add-post-form").on("submit", function (event) {
                    event.preventDefault();

                    let form = new FormData(this);

                    $.ajax({
                        url: "AddPostServlet",
                        type: "post",
                        data: form,
                        success: function (data, textStatus, jqXHR) {

                           
                           
                                swal("Good job!", "Saved Successfully", "success");
                                
                            
                        },

                        error: function (jqXHR, textStatus, errorThrown) {
                            swal("Error!", "Something went wrong! try again", "error");
                        },
                        processData: false,
                        contentType: false

                    });


                });

            });

        </script>

        <!--Loading Post-->
        <script>
            
            function getPosts(catId,temp){
                $("#loader").show()
                $("#post-container").hide()
                $(".c-link").removeClass('active')
              $.ajax({
                    url: "Load_Post.jsp",
                    data:{cid:catId},
                    success: function (data, textStatus, jqXHR) {
                        console.log(data);
                        $("#loader").hide();
                        $("#post-container").show()
                        $("#post-container").html(data)
                         $(temp).addClass('active')
                    }
                    
                })  
              }

            $(document).ready(function () {
                let allPostRef=$('.c-link')[0]
                getPosts(0,allPostRef);
            })
        </script>

    </body>
</html>
