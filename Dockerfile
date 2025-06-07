# Use official Nginx image
FROM nginx:alpine

# Set working directory inside the container
WORKDIR /usr/share/nginx/html

# Remove default Nginx index page
RUN rm -rf ./*

# Copy static files into the container
COPY index.html .
COPY style.css .
COPY script.js .

# Expose port 80
EXPOSE 3000

# No CMD needed — default Nginx entrypoint will serve static files

