# mycobot-setup-tools

myCobotのセットアップスクリプトです。  
UbuntuでmyCobotにファームウェアを書き込み、PythonのAPIからmyCobotを動かすことができます。

以下の環境で動作確認をしています。

* Ubuntu 18.04.5 LTS
* Docker 20.10.1

手動で実行したときのログはこちらです。  
https://zenn.dev/tiryoh/scraps/c6800edd909817

## 使い方

### 0. Elephant Roboticsが公開しているmyCobotのソフトウェアをダウンロード

[elephantrobotics/myCobot](https://github.com/elephantrobotics/myCobot)をダウンロードしてきます。  
ファイルサイズが大きいバイナリも多数アップロードされているので時間がかかります。

```
./scripts/00-clone-source.sh
```

### 1. ファームウェア書き込みソフトウェアを用意

M5Stackの中身はESP32なので、ESP32の書き込みに使う[espressif/esptool](https://github.com/espressif/esptool)をセットアップします。  
Python製ソフトウェアでPythonのバージョン違いで動いたり動かなかったりするのでDockerイメージを作成します。  
Dockerfileは[Tiryoh/docker-esptool](https://github.com/Tiryoh/docker-esptool)を用います。


```
./scripts/01-prepare-flash-tool.sh
```

### 2. M5Stack BasicにTransponderファームウェア書き込み

[Tiryoh/docker-esptool](https://github.com/Tiryoh/docker-esptool)を用い、M5Stack Basicに[elephantrobotics/myCobot](https://github.com/elephantrobotics/myCobot)のファームウェアを書き込みます。

myCobot -500 User Manualによると、各M5Stackのデバイスは以下のように分かれています。

* 手先についているM5Stack ATOM Matrixがサーボの制御
    * 基本的に書き換えることはあまりないもよう
* 根本についてるM5Stack BasicがM5Stack ATOM Matrixと通信
    * UI Flowや通信ソフトウェアなどファームウェアを入れ替えて使う

今回はM5Stack BasicのファームウェアをTransponder（PCとM5Stack ATOM Matrixの通信のためのブリッジ）にします。

まず、`dmesg`コマンドで接続されているM5Stackのデバイス名を確認します。  
以下の場合は`ttyUSB0`（`/dev/ttyUSB0`）として認識されていることが確認できます。

```
[82402.097693] usb 1-14: new full-speed USB device number 13 using xhci_hcd
[82402.247350] usb 1-14: New USB device found, idVendor=10c4, idProduct=ea60, bcdDevice= 1.00
[82402.247356] usb 1-14: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[82402.247359] usb 1-14: Product: CP2104 USB to UART Bridge Controller
[82402.247362] usb 1-14: Manufacturer: Silicon Labs
[82402.247365] usb 1-14: SerialNumber: XXXXXXXX
[82402.249285] cp210x 1-14:1.0: cp210x converter detected
[82402.251242] usb 1-14: cp210x converter now attached to ttyUSB0
```

`./scripts/02-flash-m5stack-firmware.sh`に`USB_PORT`が定義されている箇所があるので書き換えます。

書き換え後、以下のコマンドでスクリプトを実行します。

```
./scripts/02-flash-m5stack-firmware.sh
```

### 3. M5Stack ATOM MatrixにTransponderと一致するバージョンのファームウェア書き込み

[Tiryoh/docker-esptool](https://github.com/Tiryoh/docker-esptool)を用い、M5Stack ATOM Matrixに[elephantrobotics/myCobot](https://github.com/elephantrobotics/myCobot)のファームウェアを書き込みます。

2021年1月12日現在、ファームウェアは頻繁にアップデートがあるようなので、念のためTransponderと同じバージョンのファームウェアを書き込みます。

M5Stack Basicのときと同様に`./scripts/03-flash-atom-matrix-firmware.sh`に`USB_PORT`が定義されている箇所があるので書き換えます。

書き換え後、以下のコマンドでスクリプトを実行します。

```
./scripts/03-flash-atom-matrix-firmware.sh
```

### 4. pymycobot（myCobot制御用Pythonライブラリ）の実行

pymycobotはmyCobot制御用Pythonライブラリです。  
Python製ソフトウェアでPythonのバージョン違いで動いたり動かなかったりするのでDockerイメージを作成します。

以下のコマンドで[Dockerfile](./Dockerfile)からDockerイメージを作成し、実行します。

```
./scripts/04-build-and-run-pymycobot.sh
```

なおpymycobotは後方互換製が失われる変更が頻繁にあるようです。必要に応じて適宜修正してください。  
例えば少し前までは`mycobot3`という名前でした。

2021年1月11日の時点での最新の[`c2d4acd`](https://github.com/elephantrobotics/myCobot/tree/c2d4acd1e1c63dd5b1a62724f57e11808fa16359)では以下のコマンドでATOM Matrixを赤色表示にできました。

```python
from pymycobot.mycobot3 import MyCobot
mycobot = MyCobot('/dev/ttyUSB0')
mycobot.set_color('ff0000')
```