# Security Policy

## Supported Versions

We actively maintain and provide security updates for the following versions of Attendrix:

| Version | Supported          | Notes                    |
| ------- | ------------------ | ------------------------ |
| 1.1.x   | :white_check_mark: | Current stable release   |
| 1.1.x   | :white_check_mark: | LTS - Critical fixes only |
| 1.0.0   | :x:                | End of life             |
| < 1.0   | :x:                | No longer supported     |

## Reporting a Vulnerability

We take security vulnerabilities seriously and appreciate your help in keeping Attendrix secure.

### How to Report

**Please do NOT report security vulnerabilities through public GitHub issues.**

Instead, please report security vulnerabilities by:

1. **Email**: Send details to `security@attendrix.com`
2. **GitHub Security Advisories**: Use the [private vulnerability reporting feature](https://github.com/SH1SHANK/attendrix/security/advisories/new)

### What to Include

When reporting a vulnerability, please include:

- **Description**: Clear description of the vulnerability
- **Steps to Reproduce**: Detailed steps to reproduce the issue
- **Impact**: Potential impact and attack scenarios
- **Environment**: 
  - Flutter version
  - Dart version
  - Platform (iOS/Android/Web)
  - Device/OS version
- **Screenshots/Videos**: If applicable
- **Suggested Fix**: If you have ideas for remediation

### Response Timeline

- **Initial Response**: Within 48 hours of report
- **Status Update**: Weekly updates on investigation progress
- **Resolution Timeline**: 
  - Critical vulnerabilities: 7 days
  - High severity: 30 days
  - Medium/Low severity: 90 days

### What to Expect

**If the vulnerability is accepted:**
- We'll work with you to understand and reproduce the issue
- We'll develop and test a fix
- We'll coordinate the disclosure timeline with you
- You'll be credited in our security advisory (unless you prefer anonymity)
- We may offer a bug bounty reward for significant findings

**If the vulnerability is declined:**
- We'll provide a detailed explanation
- We'll suggest alternative reporting channels if appropriate
- We remain open to further discussion if you disagree with our assessment

## Security Best Practices

### For Users
- Always download Attendrix from official sources
- Keep the app updated to the latest version
- Use strong, unique passwords for your account
- Report suspicious activity immediately

### For Contributors
- Follow secure coding practices outlined in CONTRIBUTING.md
- Never commit sensitive data (API keys, passwords, tokens)
- Use dependency scanning tools before submitting PRs
- Keep dependencies updated and monitor for vulnerabilities

## Security Features

Attendrix implements several security measures:

- **Data Encryption**: All sensitive data encrypted at rest and in transit
- **Authentication**: Secure user authentication with JWT tokens
- **API Security**: Rate limiting and input validation
- **Privacy**: Minimal data collection with user consent
- **Secure Storage**: Platform-specific secure storage for sensitive data

## Vulnerability Disclosure Policy

We follow responsible disclosure principles:

1. **Private Reporting**: Initial report through secure channels
2. **Investigation**: We investigate and develop fixes privately
3. **Coordinated Disclosure**: Public disclosure after fix is available
4. **Credit**: Security researchers are credited for their findings
5. **Timeline**: Reasonable timeline for fixes based on severity

## Contact Information

For security-related inquiries:
- **Maintainer**: [@SH1SHANK](https://github.com/SH1SHANK)
- **General Support**: support@attendrix.com

## Hall of Fame

We recognise security researchers who help improve Attendrix security:
- *Your name could be here!*


**Last Updated**: June 27, 2025
**Policy Version**: 1.0

