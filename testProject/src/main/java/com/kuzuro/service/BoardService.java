package com.kuzuro.service;

import java.util.List;

import com.kuzuro.domain.BoardVO;
import com.kuzuro.domain.Criteria;
import com.kuzuro.domain.SearchCriteria;

public interface BoardService {
	public void writer(BoardVO vo) throws Exception;
	public BoardVO read(int bno)throws Exception;
	public void update(BoardVO vo) throws Exception;
	public void delete(int bno)throws Exception;
	public List<BoardVO> list()throws Exception;
	/*목록 + 페이지*/
	public List<BoardVO> listPage(Criteria cri)throws Exception;
	public int listCount() throws Exception;
	
	public List<BoardVO>listSearch(SearchCriteria scri)throws Exception;
	public int countSearch(SearchCriteria scri)throws Exception;
	
	
}
