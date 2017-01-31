'use strict'


module.exports = (ctx) => {
  return `
  worker_processes  1;

  error_log  ${ctx.logs}/error.log;
  error_log  ${ctx.logs}/error.log  notice;
  error_log  ${ctx.logs}/error.log  info;

  events {
    worker_connections  1024;
  }

  http {
    include       /usr/local/etc/nginx/mime.types;
    default_type  application/octet-stream;

    log_format main '$remote_addr - $remote_user [$time_local] $status '
                    '"$request" $body_bytes_sent "$http_referer" '
                    '"$http_user_agent" "http_x_forwarded_for"';

    # Optimize response to requests
    # -----------------------------
    # More info can be found on this link: https://goo.gl/HCy2qo
    #
    sendfile            off;
    tcp_nopush          on;
    tcp_nodelay         off;
    keepalive_timeout   65;

    # Enable response compression using \`gzip\` method
    # This often helps to reduce the size of transmitted data by half or even more.
    gzip              on;
    gzip_http_version 1.0;
    gzip_comp_level   2;
    gzip_proxied      any;

    # Server Names Optimizations:
    # --------------------------
    # If a large number of server names are defined, or unusually long server names
    # are defined, tuning the @{server_names_hash_max_size} and
    # @{server_names_hash_bucket_size} directives at the http level may become necessary.
    #
    # The default value of the @{server_names_hash_bucket_size} directive may be
    # equal to 32, or 64, or another value, depending on CPU cache line size.
    # If the default value is 32 and server name is defined as “too.long.server.name.example.org”
    #
    server_names_hash_bucket_size 128;
    server_names_hash_max_size 20000;

    # Set the bucket size for hash tables used by the
    #  @{proxy_hide_header} and @{proxy_set_header} directives
    proxy_headers_hash_bucket_size 128;
    proxy_headers_hash_max_size 20000;

    server {
      listen       ${ctx.port};
      server_name  ${ctx.host};

      location / {
        root  ${ctx.root};
        try_files  $uri  $uri/  /index.php?$args ;
        index  index.php;
      }

      # configure *.PHP requests
      location ~ .php$ {
        root  ${ctx.php_root};
        try_files  $uri  $uri/  /index.php?$args ;
        index  index.html index.htm index.php;
        fastcgi_param PATH_INFO $fastcgi_path_info;
        fastcgi_param PATH_TRANSLATED $document_root$fastcgi_path_info;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;

        fastcgi_pass 127.0.0.1:9000;
        fastcgi_index index.php;
        fastcgi_split_path_info ^(.+.php)(/.+)$;
        fastcgi_intercept_errors on;
        include /usr/local/etc/nginx/fastcgi_params;
      }
    }

    include /usr/local/etc/nginx/fastcgi.conf;
    include ${ctx.sites}/*.conf;
  }`
}
