FROM odoo:latest

USER root

RUN apt-get update \
    && apt-get install -y --no-install-recommends gettext-base \
    dos2unix \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY ./odoo.conf.template /etc/odoo/odoo.conf.template
COPY ./entrypoint.sh /entrypoint.sh

RUN dos2unix /entrypoint.sh && chmod +x /entrypoint.sh

USER odoo

ENTRYPOINT ["/entrypoint.sh"]