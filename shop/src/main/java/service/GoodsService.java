package service;

import java.util.*;
import repository.*;
import vo.*;
import java.sql.*;


public class GoodsService {
	private GoodsDao goodsDao;
	private GoodsImgDao goodsImgDao;

	private DBUtil dbUtil;
	
	public void addGoods(Goods goods, GoodsImg goodsImg) {
		Connection conn = null;

		try {
			conn = new DBUtil().getConnection();
			conn.setAutoCommit(false);
			
			goodsDao = new GoodsDao();
			goodsImgDao = new GoodsImgDao();
			
			int goodsNo = goodsDao.insertGoods(conn, goods); // goodsNo가 자동생성되어 DB에 입력됨.
			if(goodsNo != 0) {
				goodsImg.setGoodsNo(goodsNo);
				if(goodsImgDao.insertGoodsImg(conn, goodsImg) == 0 ) {
					throw new Exception(); // 이미지 입력 실패시 강제로 롤백시키기 위해서.(catch절로 이동하기위해서)
				}
			}
			goodsImgDao.insertGoodsImg(conn, goodsImg);
			conn.commit();
		}catch(Exception e){
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
			lastPage = totalCount / rowPerPage; // 마지막페이지 구하기
			
			if(totalCount % rowPerPage != 0) {//나머지가 0이아닐떄 페이지1장추가
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
			
			System.out.println("conn" + conn);//conn확인
			
			list = this.goodsDao.selectGoodsListByPage(conn, rowPerPage, beginRow);
			
			System.out.println("list" + list); // list확인
			
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
