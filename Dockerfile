# php55-apache24-centos74
FROM centos:7.4.1708

# 1. setup EPEL and Remi repository, then update packages
# 2. install PHP 5.5 and Extensions
# 3. install ImageMagick
RUN yum -y install epel-release && yum -y install http://rpms.famillecollet.com/enterprise/remi-release-7.rpm && yum -y update && \
    yum -y install --enablerepo=remi,remi-php55 php php-mcrypt php-xml php-mbstring php-gd php-pdo php-mysqlnd php-pecl-xdebug && \
    yum -y install ImageMagick

# install Composer (globally)
RUN curl https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# preparation for Apache starting up
WORKDIR /var/www
EXPOSE 80
COPY ./docker-entrypoint /usr/local/bin/
RUN chmod 755 /usr/local/bin/docker-entrypoint
ENTRYPOINT ["docker-entrypoint"]

# References
# ----------
# https://qiita.com/bezeklik/items/9766003c19f9664602fe
#   * EPEL and Remi repository
# https://kohkimakimoto.github.io/getcomposer.org_doc_jp/doc/00-intro.html
#   * Composer installation
# https://getcomposer.org/doc/00-intro.md#locally
#   * some Composer installation options
# https://httpd.apache.org/docs/2.4/programs/httpd.html
#   * Apache starting command and options
# https://github.com/docker-library/php/tree/master/7.1/stretch/apache
#   * example of Apache forground-starting in Dockerfile
