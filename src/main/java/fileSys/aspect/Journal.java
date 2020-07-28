package fileSys.aspect;

import java.lang.annotation.*;

@Target({ElementType.PARAMETER, ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface Journal {
//这是注释
//        public String process() default "正常";

        public String event() default "";

}
