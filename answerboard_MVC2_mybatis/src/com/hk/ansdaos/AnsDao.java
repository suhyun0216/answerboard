package com.hk.ansdaos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.hk.ansdtos.AnsDto;
import com.hk.dbinfo.Database;
import com.sun.org.apache.bcel.internal.generic.GETSTATIC;

public class AnsDao extends SqlMapConfig {

	private String namespace = "com.hk.ans.";
		
	public AnsDao() {
	}
	

	//기능구현
	//글목록 조회 :select
	public List<AnsDto> getAllList(){
		List<AnsDto> list = new ArrayList<AnsDto>();
		SqlSession sqlSession = null;
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			list = sqlSession.selectList(namespace+"testboard");
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
		
		return list;
	}
	//글쓰기(새로운글):insert
	public boolean insertBoard(AnsDto dto) {
		int count = 0;
		SqlSession sqlSession = null;
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			count = sqlSession.insert(namespace+"insertboard", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
		return count>0?true:false;
	}
	
	//글조회수 : update
	public boolean readCount(int seq) {
		int count = 0;
		SqlSession sqlSession = null;
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			count = sqlSession.update(namespace+"readcount", seq);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
		
		return count>0?true:false;
	}
	//글 상세보기: select
	public AnsDto getBoard(int seq){
		AnsDto dto = new AnsDto();
		SqlSession sqlSession = null;
		//다이나믹 쿼리를 할때 map으로 값을 넣어줘야함
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("seq", seq);
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			dto = sqlSession.selectOne(namespace+"testboard", map);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
		return dto;
	}
	//글 수정하기 : update
	public boolean updateBoard(AnsDto dto) {
		int count = 0;
		SqlSession sqlSession = null;
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			count = sqlSession.update(namespace+"updateboard", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
		return count>0?true:false;
	}

	//글 삭제하기 : update
	
	//글 여러개 삭제하기 : update - 트랜젝션 처리
	public boolean mulDelBoard(String[] seq) {
		int count = 0;
		SqlSession sqlSession = null;
		Map<String, String[]> map = new HashMap<String, String[]>();
		map.put("seqs", seq);
		try {
			sqlSession = getSqlSessionFactory().openSession(false); //트랜젝션이라 false(autocommit X)
			count = sqlSession.update(namespace+"muldelboard", map);
			sqlSession.commit();
		} catch (Exception e) {
			sqlSession.rollback();
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
		return count>0?true:false;
	}
	//답글달기 : update & insert - 트랜젝션 처리
	//	답글을 달기전에 그룹글에서 부모의 step보다 큰 step을 가진 글들에 대해 step을 1씩 증가시켜주고(update)
	//	부모의 글에 step을 1증가시킨 값을 추가하는 답글의 step에 insert 한다
	
	public boolean replyBoard(AnsDto dto) {
		int count = 0;
		SqlSession sqlSession = null;
		try {
			sqlSession = getSqlSessionFactory().openSession(false);
			sqlSession.update(namespace+"ansupdate", dto);
			count = sqlSession.insert(namespace+"ansinsert", dto);
			sqlSession.commit();
		} catch (Exception e) {
			sqlSession.rollback();
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
		return count>0?true:false;
	}
	
	public AnsDto getBoardAjax(int seq){
		AnsDto dto = new AnsDto();
		SqlSession sqlSession = null;
		try {
			sqlSession = getSqlSessionFactory().openSession(true);
			dto = sqlSession.selectOne(namespace+"detailajax", seq);
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			sqlSession.close();
		}
		return dto;
	}
	
}
