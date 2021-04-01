<%@page import="com.tech.blog.entities.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.entities.Message"%>
<%@page import="com.tech.blog.entities.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page errorPage="error_page.jsp"%>

<%
	User user = (User) session.getAttribute("currentUser");

	if (user == null) {
		response.sendRedirect("login_page.jsp");
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<link href="css/mystyle.css" rel="stylesheet" type="text/css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<style>
.banner-background {
	clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 94%, 71% 89%, 28% 96%, 0 86%, 0 0);
}

body{
			background: url(img/background2.jpg);
			background-size: cover;
			background-attachment: fixed;
		}
</style>
</head>
<body>
	<nav
		class="navbar navbar-expand-lg navbar-dark bg-dark primary-background">
		<a class="navbar-brand" href="index.jsp"><span
			class="fa fa-asterisk"></span>Tech Blog</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active"><a class="nav-link" href="#"><span
						class="fa fa-bell-o"></span>Learn Code with Durgesh <span
						class="sr-only">(current)</span> </a></li>

				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
					role="button" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false"><span class="fa fa-check-square-o"></span>
						Categories </a>
					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
						<a class="dropdown-item" href="#">Programming Language</a> <a
							class="dropdown-item" href="#">Project Implementation</a>
						<div class="dropdown-divider"></div>
						<a class="dropdown-item" href="#">Data Structure</a>
					</div></li>
				<li class="nav-item"><a class="nav-link" href="#"><span
						class="fa fa-address-book-o"></span>Contact</a></li>
				<li class="nav-item"><a class="nav-link" href="#"
					data-toggle="modal" data-target="#add-post-modal"><span
						class="fa fa-asterisk"></span>Do Post</a></li>
			</ul>


			<ul class="navbar-nav mr-right">

				<li class="nav-item"><a class="nav-link" href="#!"
					data-toggle="modal" data-target="#profile-modal"><span
						class="fa fa-user-circle"></span><%=user.getName()%></a></li>

				<li class="nav-item"><a class="nav-link" href="LogoutServlet"><span
						class="fa fa-user-o"></span>Logout</a></li>
			</ul>

			</form>
		</div>
	</nav>


<!-- End of navbar -->

<%
	Message msg = (Message) session.getAttribute("msg");

	if (msg != null) {
%>

<div class="alert <%=msg.getCssClass()%>" role="alert">
	<%=msg.getContent()%>
</div>
<%
	session.removeAttribute("msg");
	}
%>


<!--Start Main body of the page -->

<main>
	<div class="container">
		<div class="row mt-4">
			<!-- first col -->
			<div class="col-md-4">
				<!-- categories -->

				<div class="list-group">
					<a href="#" onclick="getPost(0,this)" class="c-link list-group-item list-group-item-action active">All posts </a> 
					
					<!--  categories  -->
					
					<%
					
						PostDao postDao=new PostDao(ConnectionProvider.getConnection());
						ArrayList<Category> list1=postDao.getAllCategories();
						
						for(Category cc: list1)
						{
						%>
								<a href="#" onClick="getPost(<%=cc.getCid() %>,this)" class=" c-link list-group-item list-group-item-action"><%=cc.getName() %></a>
						<%
						}
					
					%>
					
					 
					
				</div>
			</div>

			<!-- secondt col -->
			<div class="col-md-8">
				<!-- posts -->
				
				<div class="container text-center" id="loader">
					<i class="fa fa-refresh fa-4x fa-spin"></i>
					<h3 class="mt-2">Loading...</h3>
				</div>
				<div class="container-fluid" id="post-container">
					
				</div>
			</div>
		</div>
	</div>
</main>
<!--End Main body of the page -->

<!-- Start of Profile modal -->





<!-- Start of post Moadal -->

<!-- Modal -->
<div class="modal fade" id="add-post-modal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Provide the post
					details.</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">

				<form id="add-post-form" action="AddPostServlet" method="post">

					<div class="form-group">
						<select class="form-control" name="cid">
							<option selected disabled>---Select Category---</option>

							<%
								PostDao postd = new PostDao(ConnectionProvider.getConnection());
								ArrayList<Category> list = postd.getAllCategories();

								for (Category category : list) {
							%>
							<option value="<%=category.getCid()%>"><%=category.getName()%></option>
							<%
								}
							%>


						</select>
					</div>


					<div class="form-group">
						<input name="pTitle" type="text" placeholder="Enter post title"
							class="form-control" />
					</div>
					<div class="form-group">
						<textarea name="pContent" class="form-control"
							style="height: 200px;" placeholder="Enter your content"></textarea>
					</div>
					<div class="form-group">
						<textarea name="pCode" class="form-control" style="height: 200px;"
							placeholder="Enter your program (if any)"></textarea>
					</div>
					<div class="form-group">
						<label>Select your pic..</label><br> <input type="file"
							name="pic">
					</div>
					<div class="container text-center">
						<button type="submit" class="btn btn-outline-primary">Post</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<!-- End of post Modal -->



<!-- Button trigger modal -->



<!-- profile Modal -->
<div class="modal fade" id="profile-modal" tabindex="-1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header primary-background text-white text-center">
				<h5 class="modal-title" id="exampleModalLabel">TechBlog</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="container text-center">
					<img src="pics/<%=user.getProfile()%>" class="img-fluid"
						style="border-radius: 50%; max-width: 150px"><br>
					<h5 class="modal-title mr-3" id="exampleModalLabel"><%=user.getName()%>
					</h5>

					<!--User details -->

					<div id="profile-details" class="profile-details">
						<table class="table">

							<tbody>
								<tr>
									<th scope="row">ID :</th>
									<td><%=user.getId()%></td>

								</tr>
								<tr>
									<th scope="row">Email :</th>
									<td><%=user.getEmail()%></td>

								</tr>
								<tr>
									<th scope="row">Gender :</th>
									<td><%=user.getGender()%></td>

								</tr>
								<tr>
									<th scope="row">About :</th>
									<td><%=user.getAbout()%></td>

								</tr>
								<tr>
									<th scope="row">Registered on :</th>
									<td><%=user.getDateTime().toString()%></td>

								</tr>
							</tbody>
						</table>
					</div>

					<!-- profile edit -->

					<div id="profile-edit" class="profile-edit" style="display: none;">

						<h3 class="mt-2">Please Edit Carefully</h3>

						<form action="EditServlet" method="post"
							enctype="multipart/form-data">
							<table class="table">
								<tr>
									<td>ID :</td>
									<td><%=user.getId()%></td>
								</tr>

								<tr>
									<td>Email :</td>
									<td><input type="email" class="form-control"
										name="user_email" value="<%=user.getEmail()%>"></td>
								</tr>

								<tr>
									<td>Name :</td>
									<td><input type=text " class="form-control"
										name="user_name" value="<%=user.getName()%>"></td>
								</tr>
								<tr>
									<td>Password :</td>
									<td><input type="password" class="form-control"
										name="user_password" value="<%=user.getPassword()%>"></td>
								</tr>
								<tr>
									<td>Gender :</td>
									<td><%=user.getGender()%></td>
								</tr>
								<tr>
									<td>About :</td>
									<td><textarea class="form-control" name="user_about"
											rows="3">
													<%=user.getAbout()%>
												</textarea></td>
								</tr>
								<tr>
									<td>New Profile:</td>
									<td><input type="file" class="form-control" name="image""></td>
								</tr>

							</table>

							<div>
								<button type="submit" class="btn btn-outline-primary">Save</button>
							</div>

						</form>


					</div>

				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
				<button id="edit-profile-button" type="button"
					class="btn btn-primary">EDIT</button>
			</div>
		</div>
	</div>
</div>

<!-- End of Profile modal -->

<!--Javascript-->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"
	integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
	crossorigin="anonymous"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
	integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
	crossorigin="anonymous"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
	integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
	crossorigin="anonymous"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>



<script>
	$(document).ready(function() {
		let editStatus = false;

		$('#edit-profile-button').click(function() {

			if (editStatus == false) {
				$("#profile-details").hide();
				$("#profile-edit").show();
				editStatus = true;
				$(this).text("Back");

			} else {
				$("#profile-details").show();
				$("#profile-edit").hide();
				editStatus = false;
				$(this).text("Edit");
			}

		})
	});
</script>

<!-- Start of Add post js -->

<script>
	$(document).ready(function(e) {

		$("#add-post-form").on("submit", function(event) {
			//this code gets called when form is submitted...
			event.preventDefault();
			console.log("You have clicked submit...")
			let form = new FormData(this);

			//now requesting to server
			$.ajax({
				url : "AddPostServlet",
				type : "POST",
				data : form,

				success : function(data, textStatus, errorThrown) {
					console.log(data);

					if (data.trim() == 'done') {
						swal({
							title : "Good job!",
							text : "saved successfully",
							icon : "success",

						});
					} else {
						swal({
							title : "Error!!",
							text : "Something went wrong try again...",
							icon : "error",

						});
					}
				},
				error : function(jqXHR, textStatus, errorThrown) {

				},
				processData : false,
				contentType : false
			})
		})

	});
</script>

	<!--Loading post using ajax-->
			
		<script>
		
			function getPost(catId, temp){
				
				$("#loader").show();
				$("#post-containder").hide();
				
				$(".c-link").removeClass('active');
				
				$.ajax({
					url: "load_posts.jsp",
					data: {cid: catId},
					success: function(data, textStatus, jqXHR) {
						$("#loader").hide();
						$("#post-container").show();
						$("#post-container").html(data);
						$(temp).addClass('active');
					}
				})
			}
			
			$(document).ready(function(e){
				
				let allPostRef=$(".c-link")[0];
				getPost(0,allPostRef);
				
			});
		</script>
<!-- End of Add post js -->

</body>
</html>