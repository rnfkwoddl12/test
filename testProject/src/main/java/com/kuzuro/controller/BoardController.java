package com.kuzuro.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kuzuro.domain.BoardVO;
import com.kuzuro.domain.Criteria;
import com.kuzuro.domain.PageMaker;
import com.kuzuro.domain.ReplyVO;
import com.kuzuro.domain.SearchCriteria;
import com.kuzuro.service.BoardService;
import com.kuzuro.service.ReplyService;

@Controller
@RequestMapping("/board/*")
public class BoardController {

private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
 
 @Inject
 BoardService service;
 
 @Inject
 ReplyService RepService;
 
 
 // �� �ۼ� get
 @RequestMapping(value = "/write", method = RequestMethod.GET)
 public void getWrite(HttpSession session, Model model ) throws Exception {
  logger.info("get write");
  
  Object loginInfo = session.getAttribute("member");
  
  if(loginInfo == null) {
	  model.addAttribute("msg",false);
  }
  
 }

 // �� �ۼ� post
 @RequestMapping(value = "/write", method = RequestMethod.POST)
 public String postWrite(BoardVO vo) throws Exception {
  logger.info("post write");
  
  service.writer(vo);//주석추가
  return "redirect:/";
 }
 
 @RequestMapping(value="/list",method= RequestMethod.GET)
 public void list(Model model) throws Exception{
	 logger.info("get list");
	 List<BoardVO> list = service.list();
	 model.addAttribute("list",list);
	  }
 
 @RequestMapping(value="/read",method = RequestMethod.GET)
 public void getRead(@RequestParam("bno") int bno,@ModelAttribute("scri") SearchCriteria scri, Model model )throws Exception{
	 logger.info("get read");
	 BoardVO vo = service.read(bno);
	 model.addAttribute("read",vo);
	 model.addAttribute("scri",scri);
	 List<ReplyVO> repList = RepService.readReply(bno);
	 model.addAttribute("repList",repList);
	 
 }
 
 @RequestMapping(value="/modify",method = RequestMethod.GET)
 public void getModfy(@RequestParam("bno") int bno,@ModelAttribute("scri") SearchCriteria scri, Model model)throws Exception{
	 logger.info("get Modify");
	 
	 BoardVO vo = service.read(bno);
	 model.addAttribute("modify",vo);
	 model.addAttribute("scri",scri);
	 
 }
 
 @RequestMapping(value="/delete",method = RequestMethod.GET)
 public void getDelete(@RequestParam("bno")int bno, @ModelAttribute("scri") SearchCriteria scri,Model model)throws Exception{
	 logger.info("get delete");
	 model.addAttribute("delete",bno);
	 model.addAttribute("scri",scri);
 }
 
 @RequestMapping(value="/modify",method = RequestMethod.POST)
 public String postModify(BoardVO vo,@ModelAttribute("scri") SearchCriteria scri,RedirectAttributes rttr)throws Exception{
	 logger.info("post Modify");
	 service.update(vo);
	 rttr.addAttribute("page",scri.getPage());
	 rttr.addAttribute("perPageNum",scri.getPerPageNum());
	 rttr.addAttribute("searchType",scri.getSearchType());
	 rttr.addAttribute("keyword",scri.getKeyword());
	 
	 
	 return "redirect:/board/listSearch";
 }
 
 
 @RequestMapping(value="/delete",method = RequestMethod.POST)
 public String postDelete(@RequestParam("bno")int bno,@ModelAttribute("scri") SearchCriteria scri,RedirectAttributes rttr)throws Exception{
	 
	 logger.info("post delete");
	 
	 service.delete(bno);
	 
	 rttr.addAttribute("page",scri.getPage());
	 rttr.addAttribute("perPageNum",scri.getPerPageNum());
	 rttr.addAttribute("searchType",scri.getSearchType());
	 rttr.addAttribute("keyword",scri.getKeyword());
	 
	 
	 
	 return "redirect:/board/listSearch";
 }
 
 @RequestMapping(value ="/listPage",method =RequestMethod.GET)
 public void listPage(Criteria cri, Model model)throws Exception{
	 logger.info("get list page");
	 
	 List<BoardVO> list = service.listPage(cri);
	 model.addAttribute("list",list);

	 PageMaker pageMaker = new PageMaker();
	 pageMaker.setCri(cri);
	 pageMaker.setTotalCount(service.listCount());
	 model.addAttribute("pageMaker",pageMaker);	 
 }
 
 @RequestMapping(value ="/listSearch",method =RequestMethod.GET)
 public void listSearch(@ModelAttribute("scri") SearchCriteria scri, Model model)throws Exception{
	 logger.info("get listSearch page");
	 
	 List<BoardVO> list = service.listSearch(scri);
	 model.addAttribute("list",list);

	 PageMaker pageMaker = new PageMaker();
	 pageMaker.setCri(scri);
	 pageMaker.setTotalCount(service.countSearch(scri)); 
	 model.addAttribute("pageMaker",pageMaker);	 
 }
 
 @RequestMapping(value="/replyWrite",method = RequestMethod.POST)
 public String replyWrite(ReplyVO vo, SearchCriteria scri ,RedirectAttributes rttr)throws Exception{
	 logger.info("reply Writer");
	 
	 RepService.writeReply(vo);
	 
	 rttr.addAttribute("bno", vo.getBno());
	 rttr.addAttribute("page",scri.getPage());
	 rttr.addAttribute("perPageNum",scri.getPerPageNum());
	 rttr.addAttribute("searchType",scri.getSearchType());
	 rttr.addAttribute("keyword",scri.getKeyword());
	 
	 return "redirect:/board/read";
 }
 
 @RequestMapping(value="/replyUpdate",method = RequestMethod.POST)
 public String updateReply(ReplyVO vo,SearchCriteria scri,RedirectAttributes rttr)throws Exception{
	 logger.info("reply update");
	 
	 RepService.updateReply(vo);
	 
	 rttr.addAttribute("bno", vo.getBno());
	 rttr.addAttribute("page", scri.getPage());
	 rttr.addAttribute("perPageNum", scri.getPerPageNum());
	 rttr.addAttribute("searchType", scri.getSearchType());
	 rttr.addAttribute("keyword", scri.getKeyword());
	 
	 
	 return "redirect:/board/read";
 }
 
 

 @RequestMapping(value="/replyDelete",method = RequestMethod.POST)
 public String deleteReply(ReplyVO vo,SearchCriteria scri,RedirectAttributes rttr)throws Exception{
	 logger.info("reply update");
	 
	 RepService.deleteReply(vo);
	 
	 rttr.addAttribute("bno", vo.getBno());
	 rttr.addAttribute("page", scri.getPage());
	 rttr.addAttribute("perPageNum", scri.getPerPageNum());
	 rttr.addAttribute("searchType", scri.getSearchType());
	 rttr.addAttribute("keyword", scri.getKeyword());
	 
	 
	 return "redirect:/board/read";
 }
 
 @RequestMapping(value="/replyUpdate", method = RequestMethod.GET)
 public void getReplyUpdate(@RequestParam("rno") int rno, @ModelAttribute("scri") SearchCriteria scri, Model model)throws Exception {
	 logger.info("reply update");
	 
	 ReplyVO vo = null;
	 
	 vo = RepService.readReplySelect(rno);
	 
	 model.addAttribute("readReply",vo);
	 model.addAttribute("scri",scri);
	 
	 
 }
 @RequestMapping(value="/replyDelete", method = RequestMethod.GET)
 public void getReplyDelete(@RequestParam("rno") int rno, @ModelAttribute("scri") SearchCriteria scri, Model model)throws Exception {
	 logger.info("reply delete");
	 
	 ReplyVO vo = null;
	 
	 vo = RepService.readReplySelect(rno);
	 
	 model.addAttribute("readReply",vo);
	 model.addAttribute("scri",scri);
	 
	 
 } 
 
 
  
}

