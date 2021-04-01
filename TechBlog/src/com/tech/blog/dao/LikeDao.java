package com.tech.blog.dao;
import java.sql.*;
public class LikeDao {

	Connection con;
	
	public LikeDao(Connection con) {
		this.con = con;
	}

	public boolean insertLike(int postId, int userId) {
		boolean f=false;
		try {
			String query = "insert into liked(pid,uid) values(?,?)";
			PreparedStatement pstmt=con.prepareStatement(query);
			pstmt.setInt(1, postId);
			pstmt.setInt(2, userId);
			pstmt.executeUpdate();
			
			f=true;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}

	public int countLikeOnPost(int postId) {
		int count=0;
		
		try {
			String query="select count(*) from liked where pid=?";
			PreparedStatement pstmt=con.prepareStatement(query);
			pstmt.setInt(1, postId);
			ResultSet set= pstmt.executeQuery();
			
			if(set.next())
			{
				count=set.getInt("count(*)");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return count;
	}

	public boolean isLikedByUser(int postId, int userId) {
		boolean f=false;
		
		try {
			String query="select * from liked where pid=? and uid=?";
			PreparedStatement pstmt=con.prepareStatement(query);
			pstmt.setInt(1, postId);
			pstmt.setInt(2, userId);
			ResultSet set=pstmt.executeQuery();
			if(set.next()) {
				f=true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return false;
	}

	public boolean deleteLike(int postId, int userId) {
		boolean f=false;
		
		try {
			PreparedStatement pstmt=con.prepareStatement("delete from liked where pid=? and uid=?");
			pstmt.setInt(1, postId);
			pstmt.setInt(2, userId);
			ResultSet set=pstmt.executeQuery();
			f=true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return f;
	}
}
