package fileSys.interceptor;

import fileSys.bean.User;
import org.springframework.lang.Nullable;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UserLoginInterceptor implements HandlerInterceptor {
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        User user = (User) request.getSession().getAttribute("user");
        System.out.println("进入拦截器的请求路径为"+request.getRequestURI());
        if (user == null) {//是否有登陆过
            if (request.getHeader("x-requested-with") != null
                    && request.getHeader("x-requested-with").equalsIgnoreCase("XMLHttpRequest")) {
                //ajax请求，不能转发和重定向，只能返回一个消息如error，在ajax的error回调中跳转到登陆界面
                response.setHeader("sessionstatus", "timeout");
                response.setStatus(403);
                return false;
            } else {
                //非ajax请求，可以直接重定向到登陆页面
                response.sendRedirect(request.getContextPath() + "/user/userLoginPage.jsp");
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
