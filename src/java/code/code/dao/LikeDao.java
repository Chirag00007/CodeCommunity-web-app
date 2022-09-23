/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package code.code.dao;
import java.sql.*;
/**
 *
 * @author CHIRAG VOHRA
 */
public class LikeDao {
    Connection con;

    public LikeDao(Connection con) {
        this.con=con;
    }
    
    public boolean insertLike(int pid,int uid)
    {
        boolean f = false;
        try {
            String q = "insert into liked(pid,uid)values(?,?)";
            PreparedStatement p = this.con.prepareStatement(q);
            //Vslues set...
            p.setInt(1, pid);
            p.setInt(2, uid);
            
          p.executeQuery();
            f = true;
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }
    
    public int countLikeOnPost(int pid){
        int count= 0;
        
        try {
            String q ="select count(*) from like where pid=?";
            PreparedStatement p = this.con.prepareStatement(q);
            p.setInt(1,pid);
           ResultSet set = p.executeQuery();
            if(set.next())
            {
                count = set.getInt("count(*)");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        
        return count;
    }
    
    public boolean isLikedByUser(int pid,int uid)
    {
        boolean f = false;
        
        try {
            PreparedStatement p = this.con.prepareStatement("select * from liked where pid=? and uid=?");
            p.setInt(1, pid);
            p.setInt(2, uid);
      ResultSet set =       p.executeQuery();
      if(set.next()){
          f=true;
      }
        } catch (Exception e) {e.printStackTrace();
            
        }
        
        return f;
    }
    
    public boolean deleteLike(int pid,int uid)
    {
        boolean f = false;
        try {
            PreparedStatement p = this.con.prepareStatement("delete from liked where pid=? and uid=?");
            p.setInt(1, pid);
            p.setInt(2, uid);
          p.executeUpdate();
            f = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        
        return f;
    }
}
