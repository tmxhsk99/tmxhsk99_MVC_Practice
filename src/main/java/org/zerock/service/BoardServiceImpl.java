package org.zerock.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.zerock.domain.BoardVO;
import org.zerock.mapper.BoardMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class BoardServiceImpl implements BoardService{
	/*스프링 4.3부터는 단일 파라미터를 받는 생성자의 경우 필요한 파라미터를 자동으로 주입할 수 있습니다
	 * @AllArgsConstructor는 모든 파라미터를 이용하는 생성자를 만들게됨*/
	private BoardMapper mapper;
	
	@Override
	public void register(BoardVO board) {
		log.info("register......"+board);
		mapper.insert(board);
	}

	@Override
	public BoardVO get(Long bno) {
		log.info("get...."+bno);
		return mapper.read(bno);
	}

	@Override
	public boolean modify(BoardVO board) {
		log.info("modify..."+board);
		return mapper.update(board)==1;
	}

	@Override
	public boolean remove(Long bno) {
		log.info("remove..."+bno);
		return mapper.delete(bno)==1;
	}

	@Override
	public List<BoardVO> getList() {
		log.info("getList.......");
		return mapper.getList();
	}

}
