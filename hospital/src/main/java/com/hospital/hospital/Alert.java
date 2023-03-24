package com.hospital.hospital;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

public class Alert {
	
	// 알림창만 띄우기
		public static void alert(HttpServletResponse response, String msg) {
		    try {
				response.setContentType("text/html; charset=utf-8");
				PrintWriter w = response.getWriter();
				w.write("<script>alert('"+msg+"');</script>");
				w.flush();
				w.close();
		    } catch(Exception e) {
				e.printStackTrace();
		    }
		}
		
		// 알림창만 띄우고 창닫기
		public static void alertAndClose(HttpServletResponse response, String msg) {
		    try {
		        response.setContentType("text/html; charset=utf-8");
		        PrintWriter w = response.getWriter();
		        w.write("<script>alert('"+msg+"');window.close();</script>");
		        w.flush();
		        w.close();
		    } catch(Exception e) {
		        e.printStackTrace();
		    }
		}
		
		// 알림창 띄우고 이전화면 이동
		public static void alertAndBack(HttpServletResponse response, String msg) {
		    try {
		        response.setContentType("text/html; charset=utf-8");
		        PrintWriter w = response.getWriter();
		        w.write("<script>alert('"+msg+"');history.go(-1);</script>");
		        w.flush();
		        w.close();
		    } catch(Exception e) {
		        e.printStackTrace();
		    }
		}
		
		// 알림창 띄우고 원하는 화면으로 이동(location.href)
		public static void alertAndGo(HttpServletResponse response, String msg, String url) {
		    try {
		        response.setContentType("text/html; charset=utf-8");
		        PrintWriter w = response.getWriter();
		        w.write("<script>alert('"+msg+"');location.href='"+url+"';</script>");
		        w.flush();
		        w.close();
		    } catch(Exception e) {
		        e.printStackTrace();
		    }
		}
		
		// 알림창을 두번 띄우고 원하는 화면으로 이동(location.href)
				public static void alertAndAlertAndGo(HttpServletResponse response, String msg1, String msg2, String url) {
				    try {
				        response.setContentType("text/html; charset=utf-8");
				        PrintWriter w = response.getWriter();
				        w.write("<script>alert('"+msg1+"');alert('"+msg2+"');location.href='"+url+"';</script>");
				        w.flush();
				        w.close();
				    } catch(Exception e) {
				        e.printStackTrace();
				    }
				}
		
		// 알림창 띄우고 원하는 화면으로 이동(location.replace)
		public static void alertAndRedirect(HttpServletResponse response, String msg, String url) {
			try {
				response.setContentType("text/html; charset=utf-8");
				PrintWriter w = response.getWriter();
				w.write("<script>alert('"+msg+"');");
				w.write("location.replace('"+url+"');</script>");
				w.flush();
				w.close();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}


}
