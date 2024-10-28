# sudo apt-get update -qq -y
# sudo apt-get install lcov -y

flutter test --coverage
lcov --remove coverage/lcov.info 'lib/main.dart' 'lib/firebase_options.dart' -o coverage/new_lcov.info
genhtml coverage/new_lcov.info -o coverage/html  
open coverage/html/index.html