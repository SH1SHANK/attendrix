# Contributing to Attendrix

Thank you for your interest in contributing to our Flutter app! This document provides guidelines and information for contributors.

## Table of Contents
- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Setup](#development-setup)
- [Contributing Process](#contributing-process)
- [Coding Standards](#coding-standards)
- [Testing Guidelines](#testing-guidelines)
- [Pull Request Process](#pull-request-process)
- [Issue Guidelines](#issue-guidelines)

## Code of Conduct

By participating in this project, you agree to abide by our Code of Conduct. Please be respectful, inclusive, and constructive in all interactions.

## Getting Started

### Prerequisites
- Flutter SDK (latest stable version)
- Dart SDK (comes with Flutter)
- IDE: VS Code, Android Studio, or IntelliJ IDEA
- Git

### Supported Platforms
- iOS 12.0+
- Android API level 21+
- Web (optional)

## Development Setup

1. **Fork the repository**
   ```bash
   # Fork the repo on GitHub, then clone your fork
   git clone https://github.com/SH1SHANK/attendrix.git
   cd attendrix
   ```

2. **Install Flutter dependencies**
   ```bash
   flutter pub get
   ```

3. **Run code generation** (if applicable)
   ```bash
   flutter packages pub run build_runner build
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

5. **Verify your setup**
   ```bash
   flutter doctor
   flutter test
   ```

## Contributing Process

### 1. Choose or Create an Issue
- Check existing issues for something you'd like to work on
- For new features, create an issue first to discuss the approach
- Comment on the issue to let others know you're working on it

### 2. Create a Branch
```bash
git checkout -b feature/your-feature-name
# or
git checkout -b fix/issue-number-description
```

### 3. Make Your Changes
- Follow our coding standards
- Write tests for new functionality
- Update documentation as needed
- Keep commits focused and atomic

### 4. Test Your Changes
```bash
# Run all tests
flutter test

# Run integration tests
flutter drive --target=test_driver/app.dart

# Check for linting issues
flutter analyze
```

### 5. Submit a Pull Request
- Push your branch to your fork
- Create a pull request against the main branch
- Fill out the PR template completely

## Coding Standards

### Code Style
- Follow the [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Use `flutter format` to format your code
- Run `flutter analyze` to check for issues

### Project Structure
```
lib/
├── main.dart
├── app/
│   ├── app.dart
│   └── routes/
├── core/
│   ├── constants/
│   ├── errors/
│   ├── utils/
│   └── services/
├── data/
│   ├── models/
│   ├── repositories/
│   └── sources/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
└── presentation/
    ├── pages/
    ├── widgets/
    └── providers/
```

### Naming Conventions
- **Files**: `snake_case.dart`
- **Classes**: `PascalCase`
- **Variables/Functions**: `camelCase`
- **Constants**: `SCREAMING_SNAKE_CASE`
- **Widgets**: `PascalCase` ending with descriptive suffix

### Documentation
- Add dartdoc comments for public APIs
- Include examples for complex functions
- Document any non-obvious business logic

```dart
/// Calculates the total price including tax and discounts.
/// 
/// [basePrice] The original price before modifications
/// [taxRate] Tax rate as a percentage (e.g., 0.08 for 8%)
/// [discount] Discount amount to subtract
/// 
/// Returns the final price after applying tax and discount.
/// 
/// Example:
/// ```dart
/// final total = calculateTotal(100.0, 0.08, 10.0);
/// // Returns 98.0 (100 + 8% tax - 10 discount)
/// ```
double calculateTotal(double basePrice, double taxRate, double discount) {
  // Implementation
}
```

## Testing Guidelines

### Test Structure
- **Unit Tests**: `test/unit/`
- **Widget Tests**: `test/widget/`
- **Integration Tests**: `test_driver/`

### Writing Tests
```dart
group('UserRepository', () {
  late UserRepository repository;
  late MockApiService mockApiService;

  setUp(() {
    mockApiService = MockApiService();
    repository = UserRepository(mockApiService);
  });

  test('should return user when API call is successful', () async {
    // Arrange
    when(mockApiService.getUser(any))
        .thenAnswer((_) async => mockUserData);

    // Act
    final result = await repository.getUser('123');

    // Assert
    expect(result, isA<User>());
    expect(result.id, equals('123'));
  });
});
```

### Test Coverage
- Aim for 80%+ code coverage
- Focus on business logic and critical paths
- Test edge cases and error conditions

## Pull Request Process

### PR Template
When creating a PR, include:

```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Testing
- [ ] Unit tests pass
- [ ] Widget tests pass
- [ ] Integration tests pass
- [ ] Manual testing completed

## Screenshots/Videos
Include screenshots for UI changes

## Checklist
- [ ] Code follows style guidelines
- [ ] Self-review completed
- [ ] Code is properly documented
- [ ] Tests added/updated
- [ ] No breaking changes (or properly documented)
```

### Review Process
1. Automated checks must pass (CI/CD, tests, linting)
2. At least one code review required
3. Address all feedback before merging
4. Squash commits when merging

## Issue Guidelines

### Bug Reports
- Use the bug report template
- Provide detailed reproduction steps
- Include environment information
- Add screenshots/videos when helpful

### Feature Requests
- Use the feature request template
- Explain the problem you're solving
- Provide user stories and acceptance criteria
- Consider implementation complexity

### Questions
- Check existing documentation first
- Use GitHub Discussions for general questions
- Use issues for specific technical problems

## Code Review Guidelines

### For Authors
- Keep PRs focused and reasonably sized
- Write clear commit messages
- Respond promptly to feedback
- Be open to suggestions and improvements

### For Reviewers
- Be constructive and respectful
- Focus on code quality, not personal preferences
- Explain the reasoning behind suggestions
- Approve when satisfied with the changes

## Release Process

### Versioning
We use [Semantic Versioning](https://semver.org/):
- **MAJOR**: Breaking changes
- **MINOR**: New features (backward compatible)
- **PATCH**: Bug fixes (backward compatible)

### Release Checklist
- [ ] Version number updated
- [ ] CHANGELOG.md updated
- [ ] All tests passing
- [ ] Documentation updated
- [ ] Release notes prepared

## Getting Help

For support, feature requests, or bug reports:
- 📧 **Email**: support@attendrix.com
- 🐛 **Issues**: [GitHub Issues](https://github.com/sh1shank/attendrix/issues)
- 💬 **Discussions**: [GitHub Discussions](https://github.com/sh1shank/attendrix/discussions)

Additional resources:
- **Documentation**: Check the README and wiki
- **Contact**: Reach out to maintainers for urgent matters

## Recognition

Contributors will be recognized in:
- CONTRIBUTORS.md file
- Release notes (for significant contributions)
- Annual contributor appreciation posts

## Additional Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Effective Dart](https://dart.dev/guides/language/effective-dart)
- [Flutter Best Practices](https://flutter.dev/docs/development/best-practices)

---

Thank you for contributing to Attendrix! Your contributions help make this project better for everyone. 🚀