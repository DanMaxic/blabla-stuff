export FLOWER_BROKER_API='http://guest:guest@10.0.1.46:15672/api/;http://guest:guest@10.0.2.235:15672/api/;http://guest:guest@10.0.4.13:15672/api/'
export FLOWER_BROKER='amqp://guest:guest@10.0.1.46:5672//;amqp://guest:guest@10.0.2.235:5672//;amqp://guest:guest@10.0.4.13:5672//'
export FLOWER_LOGGING='debug'


celery-prometheus-exporter --broker='amqp://guest:guest@10.0.1.65:5672//;amqp://guest:guest@10.0.2.78:5672//;amqp://guest:guest@10.0.4.195:5672//' --verbose


flower --broker_api='http://guest:guest@10.0.1.65:15672/api/;http://guest:guest@10.0.2.78:15672/api/;http://guest:guest@10.0.4.195:15672/api/'  --broker='amqp://guest:guest@10.0.1.65:5672//;amqp://guest:guest@10.0.2.78:5672//;amqp://guest:guest@10.0.4.195:5672//' --logging='DEBUG' --persistent='True'

flower \
    --broker_api='http://guest:guest@10.0.1.46:15672/api/;http://guest:guest@10.0.2.235:15672/api/;http://guest:guest@10.0.4.13:15672/api/' \
    --broker='amqp://guest:guest@10.0.1.46:5672//;amqp://guest:guest@10.0.2.235:5672//;amqp://guest:guest@10.0.4.13:5672//' \
    --logging='DEBUG' --persistent='True'


FLOWER_BROKER_API='http://guest:guest@10.0.1.46:15672/api/;http://guest:guest@10.0.2.235:15672/api/;http://guest:guest@10.0.4.13:15672/api/'
FLOWER_BROKER='amqp://guest:guest@10.0.1.46:5672//;amqp://guest:guest@10.0.2.235:5672//;amqp://guest:guest@10.0.4.13:5672//'
FLOWER_LOGGING='debug'


flower --broker_api='http://guest:guest@10.0.1.65:15672/api/'  --broker='amqp://guest:guest@10.0.1.65:5672//;amqp://guest:guest@10.0.2.78:5672//;amqp://guest:guest@10.0.4.195:5672//' --logging='DEBUG' --persistent='True'


===DEFUALT
flower --broker_api='http://guest:guest@10.0.4.45:15672/api/'  --broker='amqp://guest:guest@10.0.4.45:5672//;amqp://guest:guest@10.0.2.83:5672//;amqp://guest:guest@10.0.1.237:5672//' --logging='DEBUG' --persistent='True'