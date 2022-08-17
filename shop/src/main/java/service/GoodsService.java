package service;

import java.util.*;
import repository.*;
import vo.*;
import java.sql.*;


public class GoodsService {
	private GoodsDao goodsDao;
	private GoodsImgDao goodsImgDao;

	private DBUtil dbUtil;
	
	//goods 수정하기
	public int updateGoodsOne(Goods goods) {
		Connection conn = null;
		int row = 0;
		
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false);
			
			GoodsDao goodsDao = new GoodsDao();
			row = goodsDao.updateGoods(conn, goods);
			
			System.out.println("goods row 확인 " + row);
			
			conn.commit();
		}catch(Exception e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}finally {
				try {
					conn.close();
				} catch (SQLException e1) {
					e1.printStackTrace();
				}
			}
		}
		return row;
	}
	
	//
	public int addGoods(Goods goods, GoodsImg goodsImg) {
		int goodsNo = 0;
		
		Connection conn = null;
		
		try {
			conn =  new DBUtil().getConnection();
			conn.setAutoCommit(false);
			
			goodsDao = new GoodsDao();
			goodsImgDao = new GoodsImgDao();
			
			goodsNo = goodsDao.insertGoods(conn, goods); // goodsNo
			System.out.println("goodsNo " + goodsNo);
			
			if(goodsNo != 0) {
				goodsImg.setGoodsNo(goodsNo);
				
				if(goodsImgDao.insertGoodsImg(conn, goodsImg) == 0) {
					throw new Exception();
				}
			}
			conn.commit();
		}catch(Exception e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}try {
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return goodsNo;
	}
	
	public Map<String, Object> getGoodsAndImgOne(int goodsNo) {
		Map<String , Object> map =null;
		Connection conn = null;
		this.goodsDao = new GoodsDao();
		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false);
			
			map = goodsDao.selectGoodsAndImageOne(conn, goodsNo);
			
			if(map==null) {
				throw new Exception();
			}
			conn.commit();
		}catch(Exception e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return map;
		
	}
	
	public int lastPage(int rowPerPage){
		int lastPage = 0;
		int totalCount = 0;
		Connection conn = null;
		
		this.goodsDao = new GoodsDao();
		
		try {
			conn = new DBUtil().getConnection();
			totalCount = goodsDao.GoodsCount(conn);
			lastPage = totalCount / rowPerPage; 
			
			if(totalCount % rowPerPage != 0) {
				lastPage +=1; 
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return lastPage;
	}
	
	public List<Goods> getGoodsListByPage(final int rowPerPage , final int currentPage){
		List<Goods> list = null;
		Connection conn = null;

		this.goodsDao = new GoodsDao();
		
		int beginRow = (currentPage - 1) * rowPerPage;
		
		try {
			conn = this.dbUtil.getConnection();
			
			System.out.println("conn" + conn);//conn
			
			list = this.goodsDao.selectGoodsListByPage(conn, rowPerPage, beginRow);
			
			System.out.println("list" + list); // list
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	}
}
