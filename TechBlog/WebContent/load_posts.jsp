<%@page import="com.tech.blog.entities.User"%>
<%@page import="com.tech.blog.dao.LikeDao"%>
<%@page import="java.util.List"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>

<script src="js/myjs.js" type="text/javascript"></script>
<div class="row">

<%
	User user=(User)session.getAttribute("currentUser");

	Thread.sleep(1000);
	
	PostDao postDao=new PostDao(ConnectionProvider.getConnection());
	
	int cid=Integer.parseInt(request.getParameter("cid"));

	List<Post> posts=null;
	
	if(cid==0){
		posts=postDao.getAllPosts();
	}else {
		posts=postDao.getPostByCatId(cid);
	}
	
	if(posts.size()==0){
		out.println("<h3 class='display-3 text-center'>No post in this category</h3>");
		return;
	}
	
	for(Post p: posts)
	{
		%>
			<div class="col-md-6 mt-2">
				<div class="card">
					<img class="card-img-top" src="blog_pics/<%=p.getpPic() %>" alt="Card image cap">
					<div class="card-body">
						<b><%=p.getpTitle() %></b>
						<p><%=p.getpContent() %></p>
					</div>
					
						<div class="card-footer primary-background text-center">
						<%
							LikeDao likeDao=new LikeDao(ConnectionProvider.getConnection());
						%>
							<a href="#!" onclick="doLike(<%=p.getpId() %>,<%=user.getId() %>)" class="btn btn-outline-light btn-sm"><i class="fa fa-thumbs-o-up"></i><span class="like-counter"><%=likeDao.countLikeOnPost(p.getpId()) %></span></a>
							<a href="show_blog_page.jsp?post_id=<%=p.getpId() %>" class="btn btn-outline-light btn-sm"> Read More...</a>
							<a href="#!" class="btn btn-outline-light btn-sm"><i class="fa fa-commenting-o"></i><span>20</span></a>
							
						</div>
						
				 </div>
			</div>
			
		<%
	}

%>

</div>