docker run --rm --network rdenewdocumentation-main_my_network -e SONAR_HOST_URL=http://SonarQube:9000 -e SONAR_TOKEN=sqp_835064796311f7b40ad3f044669aa8aa2020422d -e SONAR_SCANNER_OPTS=-Dsonar.projectKey=doc -v "C:\Users\Administrateur\Downloads\rdenewdocumentation-main\rdenewdocumentation-main/src:/usr/src" sonarsource/sonar-scanner-cli


sonar-scanner \
  -Dsonar.projectKey=doc \
  -Dsonar.sources=. \
  -Dsonar.host.url=http://localhost:9000 \
  -Dsonar.token=sqp_835064796311f7b40ad3f044669aa8aa2020422d
