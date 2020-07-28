package fileSys.interceptor;

import fileSys.bean.Admin;
import org.springframework.lang.Nullable;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AdminLoginInterceptor  implements HandlerInterceptor {
        public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
                throws Exception {
            Admin admin = (Admin) request.getSession().getAttribute("admin");
            System.out.println("进入拦截器的请求路径为"+request.getRequestURI());
            if (admin == null) {//是否有登陆过
                if (request.getHeader("x-requested-with") != null
                        && request.getHeader("x-requested-with").equalsIgnoreCase("XMLHttpRequest")) {
                    //ajax请求，必须返回一个消息，如error，在ajax的error中跳转到登陆界面
                    response.setHeader("sessionstatus", "timeout");
                    response.setStatus(403);
                    return false;
                } else {
                    //非ajax请求，可以直接重定向到登陆页面
                    response.sendRedirect(request.getContextPath() + "/admin/login.jsp");
                    return false;
                }
            }
            return true;
        }

        public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
                               @Nullable ModelAndView modelAndView) throws Exception {
        }

        public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler,
                                    @Nullable Exception ex) throws Exception {
        }
}
