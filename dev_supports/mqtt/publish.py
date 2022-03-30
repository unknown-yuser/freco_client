#!user/bin/env python
# -*- coding: utf-8 -*-

import paho.mqtt.client as mqtt
from time import sleep
from message import basic_pb2


def on_connected(client, userdata, flag, rc):
    print("Connected with result code " + str(rc))


def on_disconnected(client, userdata, flag, rc):
    if rc != 0:
        print("Unexpected disconnection.")


def on_publish(client, userdata, mid):
    print(f"publish: {mid}")


def main():
    client = mqtt.Client()
    client.on_connected = on_connected
    client.on_disconnected = on_disconnected
    client.on_publish = on_publish

    client.connect("localhost", 1883, 60)

    # 通信処理スタート
    client.loop_start()

    x = -3
    y = -3
    i = 0

    while True:
        i = i + 1
        y = (i % 6) - 3
        x = int((i - (y + 3)) / 6)
        i = i % 36
        position = basic_pb2.Position()
        position.x = x
        position.y = y
        client.publish("position", position.SerializeToString())
        sleep(3)


if __name__ == '__main__':
    main()
