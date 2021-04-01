package com.tech.blog.dao;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.tech.blog.entities.Category;
import com.tech.blog.entities.Post;

public class PostDao {

	Connection con;

	public PostDao(Connection con) {
		super();
		this.con = con;
	}
	
	public ArrayList<Category> getAllCategories(){
		
		ArrayList<Category> list=new ArrayList<Category>();
		
		try {
			
			String query="select * from categories";
			Statement st=this.con.createStatement();
			
		   ResultSet set=st.executeQuery(query);
		   
		   
		   while(set.next()) {
			   
			   int cid=set.getInt("cid");
			   String name=set.getString("name");
			   String description=set.getString("description");
			   Category category= new Category(cid,name,description);

			   list.add(category);
			 
			   
		   }
		} catch (Exception e) {
			 System.out.println("PostDao error ");
			e.printStackTrace();
		}
		return list;
		
	}
	

	public boolean savePost(Post post) {
		boolean f=false;
		
		try {
			
			String query="insert into posts(pTitle, pContent, pCode, pPic, catId,userId) values(?,?,?,?,?,?)";
			PreparedStatement pstmt=con.prepareStatement(query);
			
			pstmt.setString(1,post.getpTitle() );
			pstmt.setString(2, post.getpContent());
			pstmt.setString(3, post.getpCode());
			pstmt.setString(4, post.getpPic());
			pstmt.setInt(5, post.getCatId());
			pstmt.setInt(6, post.getUserId());
			
			pstmt.executeUpdate();
			f=true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return f;
	}

	//get all posts
	public List<Post> getAllPosts() {
		
		List<Post> list=new ArrayList<Post>();
		//fetch all post
		try {
			PreparedStatement pstmt=con.prepareStatement("select * from posts order by pid desc");
			ResultSet set=pstmt.executeQuery();
			
			while(set.next()) {
				
				int pid=set.getInt("pid");
				String pTitle=set.getString("pTitle");
				String pContent=set.getString("pContent");
				String pCode=set.getString("pCode");
				String pPic=set.getString("pPic");
				Timestamp date=set.getTimestamp("pDate");
				int catId=set.getInt("catId");
				int userId=set.getInt("userId");
				
				Post post=new Post(pid, pTitle, pContent, pCode,pPic, date, catId, userId);
				list.add(post);
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
		
	}
	
	//fetch all post by category
	public List<Post> getPostByCatId(int catId){
		//fetch all post by catId
		List<Post> list=new ArrayList<Post>();
		//fetch all post
		try {
			PreparedStatement pstmt=con.prepareStatement("select * from posts where catId=?");
			pstmt.setInt(1, catId);
			ResultSet set=pstmt.executeQuery();
			
			while(set.next()) {
				
				int pid=set.getInt("pid");
				String pTitle=set.getString("pTitle");
				String pContent=set.getString("pContent");
				String pCode=set.getString("pCode");
				String pPic=set.getString("pPic");
				Timestamp date=set.getTimestamp("pDate");
				int userId=set.getInt("userId");
				
				Post post=new Post(pid, pTitle, pContent, pCode,pPic, date, catId, userId);
				list.add(post);
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
		
	}
	

	public Post getPostById(int postId) {
		Post post=null;
		try {
			String query="select * from posts where pid=?";
			PreparedStatement pstmt=con.prepareStatement(query);
			pstmt.setInt(1, postId);
			ResultSet set=pstmt.executeQuery();
			
			if(set.next()) {
				int pid=set.getInt("pid");
				String pTitle=set.getString("pTitle");
				String pContent=set.getString("pContent");
				String pCode=set.getString("pCode");
				String pPic=set.getString("pPic");
				Timestamp date=set.getTimestamp("pDate");
				int userId=set.getInt("userId");
				int catId=set.getInt("catId");
				
				post=new Post(pid, pTitle, pContent, pCode,pPic, date, catId, userId);
				
			}
		} catch (Exception e) {
			
		}
		
		return post;
	}
	
}
