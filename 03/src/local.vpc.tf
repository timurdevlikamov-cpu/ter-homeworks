locals {
  vpc = {
    "network_id" = "enp7i560tb28nageq0cc"
    "subnet_ids" = [
      "e9b0le401619ngf4h68n",
      "e2lbar6u8b2ftd7f5hia",
      "b0ca48coorjjq93u36pl",
      "fl8ner8rjsio6rcpcf0h",
    ]
    "subnet_zones" = [
      "ru-central1-a",
      "ru-central1-b",
      "ru-central1-c",
      "ru-central1-d",
    ]
  }

  # Здесь мы создаем результат трансформации
  vpc_updated = merge(local.vpc, {
    subnet_ids   = [for i, v in local.vpc.subnet_ids : v if i != 2]
    subnet_zones = [for i, v in local.vpc.subnet_zones : v if i != 2]
  })

  list_1 = [for i in range(1, 100) : format("rc%02d", i)]
  list_2 = [for i in range(1, 97) : format("rc%02d", i) if (i == 19) || (i % 10 != 0 && i % 10 != 7 && i % 10 != 8 && i % 10 != 9)]

}
