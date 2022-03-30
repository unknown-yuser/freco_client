#!user/bin/env python
# -*- coding: utf-8 -*-

import paho.mqtt.client as mqtt
from time import sleep
from .message import basic_pb2

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

    client.on_connect("localhost", 1883, 60)

    # 通信処理スタート
    client.loop_start()

    # TODO: キーボード入力の受付
    while True:
        # TODO: メッセージの編集
        client.publish("position", "message")
        sleep(3)

if __name__ == '__main__':
    main()