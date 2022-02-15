package org.ProjectHub.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.AllArgsConstructor;

@Controller
@AllArgsConstructor
public class CalController {
	
	@RequestMapping(value = "/calendar", method = RequestMethod.GET)
	public String calendarPage() {
		return "calendarPage";
	}

}
