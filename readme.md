Инфраструктура состоит из:
- сервер баз данных mysql-кластер из 3 виртуалных машин (ВМ) db01, db02, db03.
- два application сервера (2 ВМ) app01, app02
- сервер мониторинга (1 ВМ) mon01
- баллансировщик нагрузки (используется облачный)

Требования из ТЗ
1. Операционная система виртуальных машин Ubuntu 20.04LTS
2. Ресурсные емкости всех виртуальных машин 1vcpu, 2G vram, 20Gb диск. 
3. Система управления конфигурациями Ansible
4. Версии БД - последние stable, совместимые с актуальной версией WordPress
5.


