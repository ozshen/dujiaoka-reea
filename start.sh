#!/bin/sh

if [ -f "/dujiaoka/.env" ]; then

    # Set permissions
    if [ -d "./storage" ]; then
        chown -R application ./storage
    fi

    if [ -d "./uploads" ]; then
        chown -R application ./uploads
    fi

    if [ "$INSTALL" != "true" ]; then
        echo "ok" > install.lock
    fi

    # Run start hooks
    echo "Running start hooks..."
    /dujiaoka/start-hook.sh
    echo "Start hooks completed."

    php artisan clear-compiled

    supervisord -c /etc/supervisor/conf.d/supervisord.conf
else
    echo "配置文件不存在，请根据文档修改配置文件！"
fi
