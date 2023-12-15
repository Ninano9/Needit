package web.util;

import javax.servlet.http.HttpServletRequest;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.Message;
import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
import org.springframework.stereotype.Component;

@Component
@Aspect
public class LogAspect {
	private final Logger logger = LoggerFactory.getLogger( this.getClass() );
	
	@Autowired HttpServletRequest req;
	
//	@Before("bean(*Controller)")
//	public void defaultControllerLog(JoinPoint jp) {
//		logger.info("{} [{}]", req.getRequestURI(), req.getMethod());
//	}
//	
//	@Before("bean(*ServiceImpl)")
//	public void defaultServiceLog(JoinPoint jp) {
//		logger.info("{}", req.getRequestURI(), req.getMethod());
//	}
	
	@Before("execution(* *..controller..*.*(..))")
//	@Before("execution(* a.b.c.HomeController.home(..))")
	public void controllerLog() {
		logger.info("{} [{}]", req.getRequestURI(), req.getMethod());
	}
	
	@Before("execution(* *..service..*.*(..))")
	public void serviceLog(JoinPoint jp) {
		logger.info("{}", jp.getSignature().toShortString());
	}

}
