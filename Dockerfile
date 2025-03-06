# Nginx Image
FROM nginx:alpine

# Copy the custom index.html 
COPY index.html /usr/share/nginx/html/index.html

# Expose port 80
EXPOSE 80

# Use non-root user for security
USER nginx
