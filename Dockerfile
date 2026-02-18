# Используем официальный образ Nginx
FROM nginx:alpine

# Устанавливаем необходимые утилиты (опционально)
RUN apk add --no-cache curl vim

# Удаляем дефолтную конфигурацию
RUN rm -rf /etc/nginx/conf.d/default.conf

# Копируем наши конфигурационные файлы
COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY nginx/conf.d/ /etc/nginx/conf.d/

# Копируем HTML файлы
COPY html/ /usr/share/nginx/html/

# Создаем директорию для логов
RUN mkdir -p /var/log/nginx

# Открываем порты
EXPOSE 80 443

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost/ || exit 1

# Запускаем Nginx
CMD ["nginx", "-g", "daemon off;"]