package com.tech.blog.servlets;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.tech.blog.dao.PostDao;
import com.tech.blog.entities.Post;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import com.tech.blog.helper.Helper;

/**
 * Servlet implementation class AddPostServlet
 */
@WebServlet("/AddPostServlet")
@MultipartConfig
public class AddPostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddPostServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		
		int cid=Integer.parseInt(request.getParameter("cid"));
		String pTitle=request.getParameter("pTitle");
		String pContent=request.getParameter("pContent");
		String pCode=request.getParameter("pCode");
		Part part=request.getPart("pic");
		//getting current user Id
		HttpSession session=request.getSession();
		User user=(User)session.getAttribute("currentUser");
		int userId=user.getId();
	
		Post post=new Post(pTitle, pContent, pCode, part.getSubmittedFileName(), cid,userId);
		PostDao postDao=new PostDao(ConnectionProvider.getConnection());
		if(postDao.savePost(post)) {
			String path = request.getRealPath("/")+"blog_pics"+File.separator+ part.getSubmittedFileName();
			Helper.saveFile(part.getInputStream(), path);
			out.print("done");
			
		}else {
			out.println("error");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
