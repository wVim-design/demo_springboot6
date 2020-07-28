package fileSys.aspect;

import fileSys.bean.Admin;
import fileSys.bean.Journal;
import fileSys.mapper.JournalMapper;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Around;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.Method;

//@Aspect
@Component
public class JournalAspect {

//    @Pointcut("execution (* fileSys.controller.AdminController.*(..))")
//    public  void adminPointcut() {
//
//    }

    @Around("adminPointcut()")
    public Object around(JoinPoint joinPoint) throws Throwable {
        System.out.println("==========开始执行环绕通知===============");
        return ((ProceedingJoinPoint) joinPoint).proceed();

    }

    @AfterReturning("adminPointcut()")
    public void normalRec(JoinPoint joinPoint) throws ClassNotFoundException, IOException {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        HttpSession session = request.getSession();
        Admin admin = (Admin) session.getAttribute("admin");
        try {
            if(admin==null){//不为null表示账号存在，null表示账号不存在，不存在账号的登陆不会有日志
                System.out.println("不存在的账号尝试登陆");
            }else {
                String targetName = joinPoint.getTarget().getClass().getName();
                String methodName = joinPoint.getSignature().getName();//代理对象的方法名
                Object[] arguments = joinPoint.getArgs();
                Class targetClass = Class.forName(targetName);
                Method[] methods = targetClass.getMethods();//被代理对象的所有public方法名

                String event = "";

                for (Method method : methods) {
                    if (method.getName().equals(methodName)) {
                        Class[] clazzs = method.getParameterTypes();
                        if (clazzs.length == arguments.length) {
                            event = method.getAnnotation(fileSys.aspect.Journal.class).event();//找到对应方法的注解。Annotation类
                            break;
                        }
                    }
                }
                fileSys.bean.Journal journal = new fileSys.bean.Journal();
                journal.setEvent(event);
                journal.setAdminAccount(admin.getAccount());

                String resource = "SqlMapConfig1.xml";
                InputStream inputStream = null;
                System.out.println("日志");
                inputStream = Resources.getResourceAsStream(resource);
                SqlSession sqlSession = new SqlSessionFactoryBuilder().build(inputStream).openSession();
                sqlSession.getMapper(JournalMapper.class).insertJournal(journal);
                sqlSession.commit();
                System.out.println("=====controller后置通知结束=====");
            }
        }catch (Exception e) {
            e.printStackTrace();
            throw e;
        }

    }

    @AfterThrowing("adminPointcut()")
    public void exceptionRec(JoinPoint joinPoint) throws ClassNotFoundException, IOException {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        HttpSession session = request.getSession();
        Admin admin = (Admin) session.getAttribute("admin");
        try {
            if(admin==null){//不为null表示账号存在，null表示账号不存在，不存在账号的登陆不会有日志
                System.out.println("不存在的账号尝试登陆");
            }else {
                String targetName = joinPoint.getTarget().getClass().getName();
                String methodName = joinPoint.getSignature().getName();//代理对象的方法名
                Object[] arguments = joinPoint.getArgs();
                Class targetClass = Class.forName(targetName);
                Method[] methods = targetClass.getMethods();//被代理对象的所有public方法名

                String event = "";

                for (Method method : methods) {
                    if (method.getName().equals(methodName)) {
                        Class[] clazzs = method.getParameterTypes();
                        if (clazzs.length == arguments.length) {
                            event = method.getAnnotation(fileSys.aspect.Journal.class).event();//找到对应方法的注解。Annotation类
                            break;
                        }
                    }
                }
                fileSys.bean.Journal journal = new Journal();
                journal.setEvent(event);
                journal.setAdminAccount(admin.getAccount());
                String resource = "SqlMapConfig1.xml";
                InputStream inputStream = null;
                System.out.println("日志");
                inputStream = Resources.getResourceAsStream(resource);
                SqlSession sqlSession = new SqlSessionFactoryBuilder().build(inputStream).openSession();
                sqlSession.getMapper(JournalMapper.class).insertJournal(journal);
                sqlSession.commit();
                System.out.println("=====controller异常通知结束=====");
            }
        }catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }


}
