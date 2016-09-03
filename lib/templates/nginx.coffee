'use strict'

module.exports = (config) ->
  return "
  worker_processes  1;
  \n
  \n#error_log  #{config.config_dir}/logs/error.log;
  \n#error_log  #{config.config_dir}/logs/error.log  notice;
  \n#error_log  #{config.config_dir}/logs/error.log  info;
  \n
  \nevents {
  \n  worker_connections  1024;
  \n}
  \n
  \nhttp {
  \n  include       /usr/local/etc/nginx/mime.types;
  \n  default_type  application/octet-stream;
  \n
  \n  log_format main '$remote_addr - $remote_user [$time_local] $status '
  \n                  '\"$request\" $body_bytes_sent \"$http_referer\" '
  \n                  '\"$http_user_agent\" \"http_x_forwarded_for\"';
  \n
  \n  # Optimize response to requests
  \n  # -----------------------------
  \n  # More info can be found on this link: https://goo.gl/HCy2qo
  \n  #
  \n  sendfile            off;
  \n  tcp_nopush          on;
  \n  tcp_nodelay         off;
  \n  keepalive_timeout   65;
  \n
  \n  # Enable response compression using `gzip` method
  \n  # This often helps to reduce the size of transmitted data by half or even more.
  \n  gzip              on;
  \n  gzip_http_version 1.0;
  \n  gzip_comp_level   2;
  \n  gzip_proxied      any;
  \n
  \n  # Server Names Optimizations:
  \n  # --------------------------
  \n  # If a large number of server names are defined, or unusually long server names
  \n  # are defined, tuning the @{server_names_hash_max_size} and
  \n  # @{server_names_hash_bucket_size} directives at the http level may become necessary.
  \n  #
  \n  # The default value of the @{server_names_hash_bucket_size} directive may be
  \n  # equal to 32, or 64, or another value, depending on CPU cache line size.
  \n  # If the default value is 32 and server name is defined as “too.long.server.name.example.org”
  \n  #
  \n  server_names_hash_bucket_size 128;
  \n  server_names_hash_max_size 20000;
  \n
  \n  # Set the bucket size for hash tables used by the
  \n  #  @{proxy_hide_header} and @{proxy_set_header} directives
  \n  proxy_headers_hash_bucket_size 128;
  \n  proxy_headers_hash_max_size 20000;
  \n
  \n  server {
  \n    listen       8080;
  \n    server_name  localhost;
  \n
  \n    location / {
  \n      root #{config.config_dir}/www;
  \n      try_files  $uri  $uri/  /index.php?$args ;
  \n      index  index.php;
  \n    }
  \n
  \n    # configure *.PHP requests
  \n    location ~ \.php$ {
  \n      root  #{config.config_dir}/www;
  \n      try_files  $uri  $uri/  /index.php?$args ;
  \n      index  index.html index.htm index.php;
  \n      fastcgi_param PATH_INFO $fastcgi_path_info;
  \n      fastcgi_param PATH_TRANSLATED $document_root$fastcgi_path_info;
  \n      fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
  \n
  \n      fastcgi_pass 127.0.0.1:9000;
  \n      fastcgi_index index.php;
  \n      fastcgi_split_path_info ^(.+\.php)(/.+)$;
  \n      fastcgi_intercept_errors on;
  \n      include /usr/local/etc/nginx/fastcgi_params;
  \n    }
  \n  }
  \n
  \n  include /usr/local/etc/nginx/fastcgi.conf;
  \n  include #{config.config_dir}/sites/*.conf;
  \n}\n"
