package com.bookmyspace.shared.error;

import com.bookmyspace.shared.web.CorrelationIdFilter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.slf4j.MDC;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ProblemDetail;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.servlet.resource.NoResourceFoundException;

import java.net.URI;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * RFC 7807 Problem Details foundation. Domain-specific exception mappings arrive with feature phases.
 */
@RestControllerAdvice
public class GlobalExceptionHandler {

    private static final Logger log = LoggerFactory.getLogger(GlobalExceptionHandler.class);
    private static final URI DEFAULT_TYPE = URI.create("about:blank");

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<ProblemDetail> handleValidation(MethodArgumentNotValidException ex) {
        ProblemDetail problem = ProblemDetail.forStatus(HttpStatus.BAD_REQUEST);
        problem.setType(DEFAULT_TYPE);
        problem.setTitle("Validation Failed");
        problem.setDetail("One or more fields failed validation.");
        problem.setProperty("code", "VALIDATION_ERROR");
        problem.setProperty("correlationId", correlationId());
        problem.setProperty("errors", fieldErrors(ex));
        return ResponseEntity.badRequest()
                .contentType(MediaType.APPLICATION_PROBLEM_JSON)
                .body(problem);
    }

    @ExceptionHandler(NoResourceFoundException.class)
    public ResponseEntity<ProblemDetail> handleNotFound(NoResourceFoundException ex) {
        ProblemDetail problem = ProblemDetail.forStatus(HttpStatus.NOT_FOUND);
        problem.setType(DEFAULT_TYPE);
        problem.setTitle("Not Found");
        problem.setDetail("The requested resource was not found.");
        problem.setProperty("code", "NOT_FOUND");
        problem.setProperty("correlationId", correlationId());
        return ResponseEntity.status(HttpStatus.NOT_FOUND)
                .contentType(MediaType.APPLICATION_PROBLEM_JSON)
                .body(problem);
    }

    @ExceptionHandler(Exception.class)
    public ResponseEntity<ProblemDetail> handleUnexpected(Exception ex) {
        String correlationId = correlationId();
        log.error("Unhandled exception correlationId={}", correlationId, ex);

        ProblemDetail problem = ProblemDetail.forStatus(HttpStatus.INTERNAL_SERVER_ERROR);
        problem.setType(DEFAULT_TYPE);
        problem.setTitle("Internal Server Error");
        problem.setDetail("An unexpected error occurred. Provide the correlation id when contacting support.");
        problem.setProperty("code", "INTERNAL_ERROR");
        problem.setProperty("correlationId", correlationId);
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                .contentType(MediaType.APPLICATION_PROBLEM_JSON)
                .body(problem);
    }

    private static String correlationId() {
        String fromMdc = MDC.get(CorrelationIdFilter.MDC_KEY);
        return fromMdc != null ? fromMdc : "unknown";
    }

    private static List<Map<String, String>> fieldErrors(MethodArgumentNotValidException ex) {
        return ex.getBindingResult().getFieldErrors().stream()
                .map(GlobalExceptionHandler::toErrorMap)
                .toList();
    }

    private static Map<String, String> toErrorMap(FieldError error) {
        Map<String, String> map = new LinkedHashMap<>();
        map.put("field", error.getField());
        map.put("message", error.getDefaultMessage() != null ? error.getDefaultMessage() : "invalid");
        return map;
    }
}
