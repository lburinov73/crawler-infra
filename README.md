# Конфигурация terraform для crawler Kubernetes кластера в Yandex Cloud

 - Требуется S3 хранилище для хранения tfstate файлов<br/>
   (см. ```backend.tf```)
 - В секрет ```S3_CREDENTIALS``` нужно сохранить в формате base64 креденшелы IAM пользователя с доступом к созданному S3 бакету<br/>
   ```cat credentials | base64 -i```<br/>
   (формат файла с креденшелами можно посмотреть в файле ```credentials.example```)
 - Параметры Яндекс облака и kubernetes кластера задаются в файле ```terraform.tfvars```
 - В секрет ```SERVICE_ACCOUNT_KEY_FILE``` нужно сохранить ключ сервисного аккаунта YC в формате base64<br/>
   ```cat key.json | base64 -i```

Для создания кластера (или изменения его параметров) можно использовать Action *Terraform Apply*<br/>
(см. файл ```.github/workflows/terraform-apply.yml```)

Для удаления кластера можно использовать Action *Terraform Destroy*<br/>
(см. файл ```.github/workflows/terraform-destroy.yml```)

# Helm chart-ы

 - В секреты YC_TOKEN, YC_CLOUD_ID и YC_FOLDER_ID нужно сохранить параметры для подключения к Yandex облаку (API Token и IDшники облака и каталога)
 - В секреты RMQ_USERNAME, RMQ_PASSWORD, RMQ_ERLANG_COOKIE нужно сохранить креденшелы для подключения к RabbitMQ, иначе будут взяты значения по умолчанию из ```values.yaml```
Для деплоя приложения в кластер можно использовать Action *Deploy Project*<br/>
(см. файл ```.github/workflows/deploy.yml```)
