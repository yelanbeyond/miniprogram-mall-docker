FROM nginx:1.24-alpine

# 安装必要工具
RUN apk add --no-cache tzdata

# 设置时区
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 复制Nginx配置
COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/conf.d/default.conf

# 创建日志目录
RUN mkdir -p /var/log/nginx

# 设置权限
RUN chown -R nginx:nginx /var/log/nginx

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]