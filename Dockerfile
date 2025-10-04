# Stage 1: dùng Tomcat luôn, không cần Maven
FROM tomcat:9.0-jdk17

# Copy file WAR (đổi đúng tên war của bạn)
COPY baitap8_1.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
