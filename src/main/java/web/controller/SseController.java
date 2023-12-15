package web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class SseController {

	@RequestMapping("/sse/connect")
	public void connect() {
	}
	
	@RequestMapping("/sse/test")
	public void test() {
	}
	
}
