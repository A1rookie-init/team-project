package com.hospital.hospital;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

// 파일다운로드 컨트롤러

@Controller
public class DownloadController {
	
	private static final Logger logger = LoggerFactory.getLogger(DownloadController.class);
	
// 원무과 퇴원수납 페이지에서 검사지발급 버튼 누르면 들어오는 요청
    @RequestMapping("/downloadTest")
    public String download(HttpServletRequest request, Model model) {
    	logger.info("download컨트롤러의 downloadTest");
    	
    	model.addAttribute("patientIdx", request.getParameter("patientIdx"));
        model.addAttribute("dDay", request.getParameter("dDay"));
    	return "downloadTest";
    }

// download.jsp에서 파일명 클릭하면 들어오는 요청
// 경로 : "C:/Upload/testfile/excelfile"
    @RequestMapping("/downloadTestAction")
    public String downloadAction(HttpServletRequest request, HttpServletResponse response, Model model) {
    	logger.info("download컨트롤러의 downloadTestAction");
    	
    	int patientIdx = Integer.parseInt(request.getParameter("patientIdx"));
    	int dDay = Integer.parseInt(request.getParameter("dDay"));
    	model.addAttribute("patientIdx", request.getParameter("patientIdx"));
        model.addAttribute("dDay", request.getParameter("dDay"));
    	
		String uploadPath = "C:" + File.separator + "Upload" + File.separator + "testfile" + File.separator + "excelfile" + File.separator;
	    String saveFileName = request.getParameter("file");
	    File downloadFile = new File(uploadPath + saveFileName);
	    
	    byte fileByte[] = null;
		try {
			fileByte = FileUtils.readFileToByteArray(downloadFile);
			response.setContentType("application/octet-stream");
			response.setContentLength(fileByte.length);
			response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(saveFileName,"UTF-8").replaceAll("\\+"," ") +"\";");
		} catch (IOException e) {
			e.printStackTrace();
		}
	    response.setHeader("Content-Transfer-Encoding", "binary");
	    try {
			response.getOutputStream().write(fileByte);
			response.getOutputStream().flush();
			response.getOutputStream().close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	    return "redirect:insertAccept";
    }
    
 // 원무과 퇴원수납 페이지에서 약국안내도 버튼 누르면 들어오는 요청
 // 파일경로: C:/Upload/pharmfile/pharm_map.html
    @RequestMapping("/downloadPharm")
    public String downloadPharm(HttpServletRequest request, HttpServletResponse response, Model model) {
    	logger.info("download컨트롤러의 downloadPharm");
    	
    	model.addAttribute("patientIdx", request.getParameter("patientIdx"));
        model.addAttribute("dDay", request.getParameter("dDay"));
      
		String uploadPath = "C:" + File.separator + "Upload" + File.separator + "pharmfile" + File.separator;
	    String saveFileName = "pharm_map.html"; // 약국지도파일명
	    File downloadFile = new File(uploadPath + saveFileName);
	    
	    byte fileByte[] = null;
		try {
			fileByte = FileUtils.readFileToByteArray(downloadFile);
			response.setContentType("application/octet-stream");
			response.setContentLength(fileByte.length);
			response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(saveFileName,"UTF-8").replaceAll("\\+"," ") +"\";");
		} catch (IOException e) {
			e.printStackTrace();
		}
	    response.setHeader("Content-Transfer-Encoding", "binary");
	    try {
			response.getOutputStream().write(fileByte);
			response.getOutputStream().flush();
			response.getOutputStream().close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	    return "redirect:insertAccept";
    }    
	
}
