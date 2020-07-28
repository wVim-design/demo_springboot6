package fileSys.bean;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.*;
import org.springframework.stereotype.Component;

/**
 * 通过注解的方式 添加增强
 */
@Aspect
@Component
public class SleepAdvice03 {

	//设置切入点
	@Pointcut("execution(* *.sleep(..))")
	public void sleepPointcut() {
	}

	//前置增强
	@Before("sleepPointcut()")
	public void beforeSleep() {
		System.out.println("前置增强");
	}

	//后置增强
	@AfterReturning(value = "sleepPointcut()")
	public void afterSleep() {
		System.out.println("后置增强");
	}

	// 环绕增强
	@Around(value = "execution(* *.sleep(..))")
	public void around(ProceedingJoinPoint pjp) throws Throwable {
		System.out.println("环绕前置增强");
		pjp.proceed();
		System.out.println("环绕后置增强");
	}

	// 异常增强
	@AfterThrowing(pointcut = "sleepPointcut()")
	public void afterThrowing(){
		System.out.println("异常增强");
	}

	// 最终增强
	@After(value = "sleepPointcut()")
	public void after(){
		System.out.println("最终增强");
	}

}