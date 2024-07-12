all:

test:
	very_good test --coverage

	genhtml coverage/lcov.info -o coverage/
	dart run test_coverage_badge

.PHONY: all test
