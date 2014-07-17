<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html;charset=UTF-8"%>
<%@ page import="java.io.IOException"%>
<%@ page import="java.net.MalformedURLException"%>
<%@ page import="java.net.URL"%>
<%@ page import="org.jsoup.Jsoup"%>
<%@ page import="org.jsoup.nodes.Document"%>
<%@ page import="org.jsoup.nodes.Element"%>
<%!

	/** SQL 值中的單引號(')需要轉化為 \'  */
	public String forSQL(String sql){
		return sql.replace("'", "\\'");
	}
%>
<%
	request.setCharacterEncoding("UTF-8");

	String urlstring = request.getParameter("url");
	  URL url = null;
			try {
				url = new URL(urlstring);
			} catch (MalformedURLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	        
	        /*
	         * 向網頁伺服發出請求，並將回應分析成document。
	         * 第一個參數是：請求位置與QueryString。
	         * 第二個參數是：連線時間(毫秒)，在指定時間內若無回應則會丟出IOException
	         */       
	        Document doc = null;
			try {
				doc = Jsoup.parse(url, 3000);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				//e.printStackTrace();
				 System.out.println(e.toString());
			}
			
			Element head = doc.head();
			 String description = head.select("meta[name=description]").attr("content");
			 String title = head.select("title").html();
			    
				out.println("[{\"url\":\""+ urlstring +"\",\"description\":\""+ description +"\",\"title\":\""+ title +"\"}]");

%>
