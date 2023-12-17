RUN_DIR=${1:-.}

# run integration sample
flutter drive --driver=${RUN_DIR}/test_integration/driver/driver.dart --target=${RUN_DIR}/test_integration/navigate_test.dart
