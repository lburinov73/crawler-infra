terraform {
  backend "s3" {
    endpoint                    = "storage.yandexcloud.net"
    bucket                      = "crawler-terraform"
    region                      = "ru-central1"
    key                         = "terraform.tfstate"
    shared_credentials_file     = "./.credentials"
    skip_region_validation      = true
    skip_credentials_validation = true
  }
}
