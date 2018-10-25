package org.zerock.controller;

import java.lang.ProcessBuilder.Redirect;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.BoardVO;
import org.zerock.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardController {
	private BoardService service;
	
	@GetMapping("/list")
	public void list(Model model) {
		log.info("list");
		model.addAttribute("list",service.getList());
	}
	@GetMapping("/get")
	public void get(@RequestParam("bno") Long bno, Model model) {
		/*get 메서드에 bno값을 좀더 명시적으로 처리하는 @RequestParam을 이용해서 지정합니다 (파라미터이름과 변수이름을 기준으로 동작하기에 생략해도 무방)
		 * 게시물 전달을위해 Model을 param으로 지정함*/
		log.info("/get");
		model.addAttribute("board",service.get(bno));
	}
	@PostMapping
	public String modify(BoardVO board, RedirectAttributes rttr) {
		log.info("modify :" + board);
		if(service.modify(board)) {
			rttr.addFlashAttribute("result","success");
		}
		return "redirect:/board/list";
	}
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno, RedirectAttributes rttr) {
		log.info("remove...."+bno);
		if(service.remove(bno)) {
			rttr.addFlashAttribute("result","success");
		}
		return "redirect:/board/list";
	}
}