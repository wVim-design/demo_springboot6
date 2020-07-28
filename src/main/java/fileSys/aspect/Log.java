package fileSys.aspect;


import java.lang.annotation.*;

/**
 * 元注解：元注解是指仅能被注解使用的注解,包括@Retention @Target @Documented @Inherited四种。
 * @Retention: 定义注解的保留策略
	@Retention(RetentionPolicy.SOURCE)   //注解仅存在于源码中，在class字节码文件中不包含
	@Retention(RetentionPolicy.CLASS)     // 默认的保留策略，注解会在class字节码文件中存在，但运行时无法获得，
	@Retention(RetentionPolicy.RUNTIME)  // 注解会在class字节码文件中存在，在运行时可以通过反射获取到
	ps：不写时@Retention时注解的保留策略为RetentionPolicy.CLASS.
 * @Target：定义注解的作用目标
 	@Target(ElementType.TYPE)   //接口、类、枚举、注解
	@Target(ElementType.FIELD) //字段、枚举的常量
	@Target(ElementType.METHOD) //方法
	@Target(ElementType.PARAMETER) //方法参数
	@Target(ElementType.CONSTRUCTOR)  //构造函数
	@Target(ElementType.LOCAL_VARIABLE) //局部变量
	@Target(ElementType.ANNOTATION_TYPE) //注解，如元注解的@Target类型就是ElementType.ANNOTATION_TYPE
	@Target(ElementType.PACKAGE) //包
	@Target(ElementType.TYPE_PARAMETER) //jdk1.8新增，用于Type parameter declaration
 	@Target(ElementType.TYPE_USE) //jdk1.8新增，用于Use of a type
	ps：Target的elementType表示为一个数组，如@Target({ElementType.PARAMETER, ElementType.METHOD})。
	不写时@Target时租借的目标可以是任何可注解元素
 * @Documented：说明被修饰的注解将被包含在javadoc中
 * ps：不写@Documented则不被包含
 * @Inherited：说明被修饰的注解A可被子类继承，即当找至于继承链顶端(Object)都没有找到A时才说明该类A注解
 * ps：不写@Inherited表示注解不能被继承
 * @author zx
 *
 */



@Target({ElementType.PARAMETER, ElementType.METHOD,ElementType.TYPE_PARAMETER})
@Retention(RetentionPolicy.RUNTIME)  
@Documented  
public @interface Log {

    /** 要执行的操作类型  比如：增加操作 **/  
    public String operationType() default "";  
     
    /** 要执行的具体操作  比如：添加用户 **/  
    public String operationName() default "";

	/** 其它··· **/
    public String abc() default "";
}
