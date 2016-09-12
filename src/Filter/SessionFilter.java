package Filter;

import org.hibernate.Session;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Created by 1234ztc on 2016/7/3.
 */
public class SessionFilter implements Filter {
    public void destroy() {
    }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest servletRequest=(HttpServletRequest)request;
        HttpServletResponse servletResponse=(HttpServletResponse)response;
        HttpSession session=servletRequest.getSession();
        String path =servletRequest.getRequestURI();
        String username=(String)session.getAttribute("username");
        if(path.indexOf("/index.jsp") > -1) {
                     chain.doFilter(servletRequest, servletResponse);
                      return;
                 }
        if (username == null || "".equals(username)) {
                        // 跳转到登陆页面
                     servletResponse.sendRedirect("/index.jsp");
                 } else {
                      // 已经登陆,继续此次请求
                    chain.doFilter(request, response);
               }

    }

    public void init(FilterConfig config) throws ServletException {

    }

}
