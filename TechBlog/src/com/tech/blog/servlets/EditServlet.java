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

import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.Message;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import com.tech.blog.helper.Helper;

/**
 * Servlet implementation class EditServlet
 */
@WebServlet("/EditServlet")
@MultipartConfig
public class EditServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		
		//fetch all data
		
		String user_email=request.getParameter("user_email");
		String user_name= request.getParameter("user_name");
		String user_password= request.getParameter("user_password");
		String user_about= request.getParameter("user_about");
		
		Part part=request.getPart("image");
		String imageName=part.getSubmittedFileName();
		
		
		//get the user from session
		
		HttpSession session=request.getSession();
		User user=(User)session.getAttribute("currentUser");
		String oldUserImage=user.getProfile();
		
		//set New data
		user.setEmail(user_email);
		user.setName(user_name);
		user.setPassword(user_password);
		user.setAbout(user_about);
		user.setProfile(imageName);
		
		UserDao userDao=new UserDao(ConnectionProvider.getConnection());
		boolean ans=userDao.updateUser(user);
		if(ans) {
			
			
			String path = request.getRealPath("/")+"pics"+File.separator;  //path where image exist
			String oldImagePath = path+oldUserImage;								//old image path
			String newImagePath = path+user.getProfile();							//new image path
		
			//Delete old image
			if(!oldUserImage.equals("default.png")) {
				Helper.deleteFile(oldImagePath);
			}
			    
			
			//save new image
				if(Helper.saveFile(part.getInputStream(), newImagePath))
				{
					out.println("profile updated");
					Message msg = new Message("Profile details updated", "success", "alert-success");
					session.setAttribute("msg", msg);
					
				}else {
					Message msg = new Message("Something went wrong..", "error", "alert-danger");
					session.setAttribute("msg", msg);	
				}
		}else {
			Message msg = new Message("Something went wrong..", "error", "alert-danger");
			session.setAttribute("msg", msg);
		}
		response.sendRedirect("profile.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
