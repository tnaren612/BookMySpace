package com.bookmyspace.bootstrap.config;

import org.springframework.boot.context.properties.ConfigurationProperties;

@ConfigurationProperties(prefix = "bookmyspace")
public record PlatformProperties(
        String appName,
        String environment
) {
}
